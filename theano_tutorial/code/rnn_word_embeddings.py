#Recurrent Neural Network Model¶
#Raw input encoding
#A token corresponds to a word. Each token in the ATIS vocabulary is associated to an index. Each sentence is a array of indexes (int32). 
#Then, each set (train, valid, test) is a list of arrays of indexes. A python dictionnary is defined for mapping the space of indexes to the space of words.
import theano, numpy
from theano import tensor as T


#Given a sentence i.e. an array of indexes, and a window size i.e. 1,3,5,..., we need to convert each word in the sentence to a context window surrounding this particular word.
def contextwin(l, win):
    '''
    win :: int corresponding to the size of the window
    given a list of indexes composing a sentence

    l :: array containing the word indexes

    it will return a list of list of indexes corresponding
    to context windows surrounding each word in the sentence
    '''
    assert (win % 2) == 1
    assert win >= 1
    l = list(l)

    lpadded = win // 2 * [-1] + l + win // 2 * [-1] #// es la división entera
    out = [lpadded[i:(i + win)] for i in range(len(l))]

    assert len(out) == len(l)
    return out


#Word-Embeddings
#Once we have the sentence converted to context windows i.e. a matrix of indexes, we have to associate these indexes to the embeddings (real-valued vector associated to each word). Using Theano:


# nv :: size of our vocabulary
# de :: dimension of the embedding space
# cs :: context window size
nv, de, cs = 1000, 50, 5

embeddings = theano.shared(0.2 * numpy.random.uniform(-1.0, 1.0, \
    (nv+1, de)).astype(theano.config.floatX)) # add one for PADDING at the end

idxs = T.imatrix() # as many columns as words in the context window and as many lines as words in the sentence
x    = self.emb[idxs].reshape((idxs.shape[0], de*cs))



#Elman recurrent neural network
#The following (Elman) recurrent neural network (E-RNN) takes as input the current input (time t) and the previous hiddent state (time t-1). Then it iterates. The input fits this sequential/temporal structure. It consists in a matrix where the row 0 corresponds to the time step t=0, the row 1 corresponds to the time step t=1, etc.
'''
The parameters of the E-RNN to be learned are:

the word embeddings (real-valued matrix)
the initial hidden state (real-value vector)
two matrices for the linear projection of the input t and the previous hidden layer state t-1
(optionnal) bias. Recommendation: don’t use it.
softmax classification layer on top
The hyperparameters define the whole architecture:

dimension of the word embedding
size of the vocabulary
number of hidden units
number of classes
random seed + way to initialize the model
'''



class RNNSLU(object) :
    #Elman RNN model
    def __init__(self,nh,nc,ne,de,cs) : 
        #nh : Dimension hidden layer
        #nc : Number of classes
        #ne : Number of word embeddings (in vocab)
        #de : Dimension of the word embeddings
        #cs : Word windows context size
        

        ###Parameters of the model:
        #Word embaddings
        self.emb = theano.shared(name='embeddings',
                                 value = 0.2*numpy.random.uniform(-1.0, 1.0, (ne+1,de))
                                 .astype(theano.config.floatX))
        #Input layer (real vector)                                                                
        self.wx= theano.shared(name='wx',
                               value=0.2*numpy.random.uniform(-1.0,1.0,(de*cs,nh))
                               .astype(theano.config.floatX))



        #Initial hidden state (real vector)
        self.wh = theano.shared(name='wh',
                                value=0.2*numpy.random.uniform(-1.0,1.0,(nh,nh))
                                .astype(theano.config.floatX))

        self.w = theano.shared(name='w',
                               value=0.2 * numpy.random.uniform(-1.0, 1.0,(nh, nc))
                               .astype(theano.config.floatX))
        
        #Two matrices for the linear projection of the input t and the previous hidden state t-1

        self.bh = theano.shared(name='bh',
                                value=numpy.zeros(nh,
                                                  dtype=theano.config.floatX))

        self.h0 = theano.shared(name='h0', 
                                value=numpy.zeros(nh,
                                                  dtype=theano.config.floatX))


        self.b = theano.shared(name='b',
                               value=numpy.zeros(nc,
                                                 dtype=theano.config.floatX))


        #Bundle (juntandolo todo, vamos):
        
        self.params = [self.emb, self.wx, self.wh, self.w,
                       self.bh, self.b, self.h0]
        



        #We integrate the way to build the input from the embedding matrix (self.emb)

    idxs = T.imatrix()
    x = self.emb[idxs].reshape((idxs.shape[0],de*cs))
    y_sentence = T.ivector('y_sentence') #labels


        #We'll use the scan operator.  scan operation is meant to be able to describe symbolically loops, recurrent relations or dynamical systems:
    def recurrence(x_t,h_tm1) :
        #Hidden state
        h_t = T.nnet.sigmoid(T.dot(x_t,self.wx)
                             + T.dot(h_tm1, self.wh) + self.bh)
        #Output state
        s_t = T.nnet.softmax(T.dot(h_t, self.w)+self.b)


        #Usando el scan:

        [h,s],_ = theano.scan(fn = recurrence,
                              sequences = x,
                              outputs_info=[self.h0,None],
                              n_steps=x.shape[0])
        p_y_given_x_sentce = s[:,0,:]
        y_pred = T.argmax(p_y_given_x_sencence,axis=1)
        

#        Theano will then compute all the gradients automatically to maximize the log-likelihood:

        lr = T.scalar('lr')

        sentence_nll = -T.mean(T.log(p_y_given_x_sentence)
                               [T.arange(x.shape[0]), y_sentence])
        sentence_gradients = T.grad(sentence_nll, self.params)
        sentence_updates = OrderedDict((p, p - lr*g)
                                       for p, g in
                                       zip(self.params, sentence_gradients))
#Next compile those functions:

        self.classify = theano.function(inputs=[idxs], outputs=y_pred)
        self.sentence_train = theano.function(inputs=[idxs, y_sentence, lr],
                                              outputs=sentence_nll,
                                              updates=sentence_updates)
#We keep the word embeddings on the unit sphere by normalizing them after each update:

        self.normalize = theano.function(inputs=[],
                                         updates={self.emb:
                                                  self.emb /
                                                  T.sqrt((self.emb**2)
                                                  .sum(axis=1))
                                                  .dimshuffle(0, 'x')})
