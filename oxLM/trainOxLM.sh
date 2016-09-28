#$ -l h_vmem=8g
#$ -l h_rt=144:00:00                                                                                                                                         

/home/lvapeab/smt/software/OxLM/bin/train_maxent_sgd -c /home/lvapeab/oxLM/oxLMMinieuroparl.ini --model-out=/home/lvapeab/oxLM/es.5.maxent.2
