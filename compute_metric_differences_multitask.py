# The files specified in the files dict have been obtained with the following awk script:
# tail -n +2 Adam |awk '{print $1" "$6}'| sed 's/,$//' > adam
# where Adam is the output of the evaluate_from_file script (invoked with n > 0)
import itertools

task_names = ['xerox', 'ue', 'UFAL_medical_shuffled', 'europarl', 'ted']
baselines_name = 'baseline'
multiplier = 100.  # Set to 100. if you want percentages
algo_names = ['adadelta']
dest_filename = 'ter_differences'
differences = {}
max_len_baseline = []
for task in task_names:
    algo_scores = {}
    for algo in algo_names:
        file_name = task + '_' + algo
        algo_scores[algo] = map(lambda x: x.split(), open(file_name).read().split('\n')[:-1])

    baseline_name = task + '_' + baselines_name
    baseline = map(lambda x: x.split(), open(baseline_name).read().split('\n')[:-1])
    if len([int(b[0]) for b in baseline]) > len(max_len_baseline):
        max_len_baseline = [int(b[0]) for b in baseline]
    differences[task] = {}
    for algo, scores in algo_scores.iteritems():
        differences[task][algo] = {}
        for i, (n_sents, score) in enumerate(scores):
            baseline_score = float(baseline[i][1])
            differences[task][algo][n_sents] = float(score) * multiplier - baseline_score * multiplier

out_f = open(dest_filename, 'w')
to_write = 'Sentences ' + ' '.join([name for name in [task + '_' + algo for task in task_names for algo  in algo_names]]) + '\n'
out_f.write(to_write)
for i in sorted(max_len_baseline):
    to_write = str(i) + ' '
    for task in task_names:
        for algo in algo_names:
            to_write += str(differences[task][algo].get(str(i), ' nan ')) + ' '
    to_write += '\n'
    out_f.write(to_write)
out_f.close()
