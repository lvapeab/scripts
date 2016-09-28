 // general options in command line only                                                                                                     
"help", "produce help message"
"config-file,c", "configuration file (can be set without option name)"

  // general options in configuration file and selectable for command line                                                                    
"mach,m", "file name of the machine"
"src-word-list,s", "word list of the source vocabulary"
"tgt-word-list,w", "word list of the vocabulary and counts (used to select the most frequent words)"
"word-list,w", "word list of the vocabulary and counts (used to select the most frequent words)"
"input-file,i", "file name of the input n-best list"
"output-file,o", "file name of the output n-best list"
"source-file,S", "file name of the file with source sentences (needed for TM rescoring)"
"phrase-table", "rescore with a Moses on-disk phrase table"
"phrase-table2", "use a secondary Moses phrase table"
"test-data,t","test data"
"train-data,t", "training data"
"dev-data,d", "development data (optional)"
"lm,l", "file name of the machine (only necessary when using short lists)"
"output-probas", "write sequence of log-probas to file (optional)"
"cslm,c", "rescore with a CSLM"
"vocab,v", "word-list to be used with the CSLM"
"cstm,C", "rescore with a CSTM"
"vocab-source,b", "source word-list to be used with the CSTM"
"vocab-target,B", "target word-list to be used with the CSTM"
"weights,w", "coefficients of the feature functions"
"tm-scores,N", "specification of the TM scores to be used (default first 4)"

"inn,I", "number of hypothesis to read per n-best (default all)"
"outn,O", "number of hypothesis to write per n-best (default all)"
"offs,a", "add offset to n-best ID (useful for separately generated n-bests)"
"num-scores,n", "number of scores in phrase table"
"ctxt-in,c", "input context size"
"ctxt-out,C", "output context size"
"curr-iter,C", "current iteration when continuing training of a neural network"
"last-iter,I", "last iteration of neural network"
"order", "order of the LM to apply on the test data (must match CSLM, but not necessarily back-off LM)")
"mode,M", "mode of the data (1=IGN_BOS 2=IGN 3=UNK 4=IGN_UNK_ALL, 8=IGN_EOS)"
"lm-pos,p", "position of LM score (1..n, 0 means to append it)"
"tm-pos,P", "position of the TM scores, up to 4 values"
"buf-size,b", "buffer size")
"block-size,B", "block size for faster training"
"drop-out,O" , "percentage of neurons to be used for drop-out [0-1] (set by default to -1 to turn it off)"
"random-init-project,r", "value for random initialization of the projection layer"
"random-init-weights,R", "value for random initialization of the weights"
"lrate-beg,L", "initial learning rate"
"lrate-mult,M", "learning rate multiplier for exponential decrease"
"weight-decay,W", "coefficient of weight decay"
"weight-decay,W",  "coefficient of weight decay")
"backward-tm,V", "use an inverse back-ward translation model"
"renormal,R", "renormalize all probabilities, slow for large short-lists"
"recalc,r", "recalculate global scores"
"sort,s" , "sort n-best list according to the global scores"
"lexical,h", "report number of lexically different hypothesis"
"server,X" , "run in server mode listening to a named pipe to get weights for new solution extraction"


  /* set machine names */
  // machine names are defined in configuration file options to be recognized as valid options                                               
          ("machine.Mach"         )
          ("machine.Tab"          )
          ("machine.Linear"       )
          ("machine.LinRectif"    )
          ("machine.Sig"          )
          ("machine.Tanh"         )
          ("machine.Softmax"      )
          ("machine.SoftmaxStable")
          ("machine.Multi"        )
          ("machine.Sequential"   )
          ("machine.Parallel"     )
          ("machine.Split"        )
          ("machine.Split1"       )
          ("machine.Join"         )
          ;



  // machine options for many machine types except multiple machines                                                                          
  this->odMachineConf.add_options()
          ("input-dim"            ,  "input dimension")
          ("output-dim"           ,  "output dimension")
          ("nb-forward"           ,  "forward number")
          ("nb-backward"          ,  "backward number")
  ;

  // machine options for all machine types (including multiple machines)                                                                      
  this->odMachMultiConf.add_options()
          ("drop-out"             ,  "percentage of neurons to be used for drop-out [0-1], set to -1 to turn it off")
          ("block-size"           , "block size for faster training")
          ("init-from-file"       , "name of file containing all machine data")
          ;

  // machine options for linear machines (base class MachLin)                                                                                 
  this->odMachLinConf.add_options()
          ("const-init-weights"   , bpo::value<REAL>(), "constant value for initialization of the weights")
          ("ident-init-weights"   , bpo::value<REAL>(), "initialization of the weights by identity transformation")
          ("fani-init-weights"    , bpo::value<REAL>(), "random initialization of the weights by function of fan-in")
          ("fanio-init-weights"   , bpo::value<REAL>(), "random initialization of the weights by function of fan-in and fan-out")
          ("random-init-weights"  , bpo::value<REAL>(), "value for random initialization of the weights (method used by default with general
value)")
          ("const-init-bias"      , bpo::value<REAL>(), "constant value for initialization of the bias")
          ("random-init-bias"     , bpo::value<REAL>(), "value for random initialization of the bias (method used by default with general val\
ue)")
          ;
  this->odMachLinConf.add(this->odMachineConf);
  // machine options for table lookup machines (base class MachTab)                                                                           
  this->odMachTabConf.add_options()
          ("const-init-project"   , bpo::value<REAL>(), "constant value for initialization of the projection layer")
          ("random-init-project"  , bpo::value<REAL>(), "value for random initialization of the projection layer (method used by default with\
 general value)")
          ;
