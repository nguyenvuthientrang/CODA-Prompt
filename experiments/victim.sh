# bash experiments/cifar-100.sh
# experiment settings
DATASET=cifar-100
N_CLASS=200

# save directory

# hard coded inputs
GPUID='0 1 3 4'
CONFIG=configs/cifar-100_prompt.yaml
REPEAT=1
OVERWRITE=0

###############################################################

for i in 2 
do
    OUTDIR=outputs_attack_l2p/${DATASET}/poison-10-task-target-$i
    NOISE_PATH=outputs/cifar-100/poison-10-task-target-2/l2p++/triggers/repeat-1/task-trigger-gen/target-2-04-10-04_11_38.npy
    mkdir -p $OUTDIR

    python3 -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
        --learner_type prompt --learner_name L2P \
        --prompt_param 30 20 -1 \
        --log_dir ${OUTDIR}/l2p++ \
        --surrogate_dir outputs_surrogate/cifar-100/10-task/l2p++/models/repeat-1/task-surrogate/ \
        --target_lab $i \
        --noise_path $NOISE_PATH

    python3 -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
        --learner_type prompt --learner_name CODAPrompt \
        --prompt_param 100 8 0.0 \
        --log_dir ${OUTDIR}/coda-p \
        --surrogate_dir outputs_surrogate/cifar-100/10-task/coda-p/models/repeat-1/task-surrogate/ \
        --target_lab $i \
        --noise_path $NOISE_PATH

    OUTDIR=outputs_attack_coda/${DATASET}/poison-10-task-target-$i
    NOISE_PATH=outputs/cifar-100/poison-10-task-target-2/coda-p/triggers/repeat-1/task-trigger-gen/target-2-04-10-14_52_24.npy
    mkdir -p $OUTDIR

    python3 -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
        --learner_type prompt --learner_name L2P \
        --prompt_param 30 20 -1 \
        --log_dir ${OUTDIR}/l2p++ \
        --surrogate_dir outputs_surrogate/cifar-100/10-task/l2p++/models/repeat-1/task-surrogate/ \
        --target_lab $i \
        --noise_path $NOISE_PATH

    python3 -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
        --learner_type prompt --learner_name CODAPrompt \
        --prompt_param 100 8 0.0 \
        --log_dir ${OUTDIR}/coda-p \
        --surrogate_dir outputs_surrogate/cifar-100/10-task/coda-p/models/repeat-1/task-surrogate/ \
        --target_lab $i \
        --noise_path $NOISE_PATH
done

# for i in 2 12 22 32 42 52 62 72 82 92
# do
#     OUTDIR=outputs/${DATASET}/poison-10-task-target-$i
#     NOISE_PATH=/home/ubuntu/Thesis/outputs/cifar-100/attack/coda-p/triggers/repeat-1/task-trigger-gen/target-$i.npy
#     mkdir -p $OUTDIR

#     python3 -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
#         --learner_type prompt --learner_name CODAPrompt \
#         --prompt_param 100 8 0.0 \
#         --log_dir ${OUTDIR}/coda-p \
#         --target_lab $i

#     python3 -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
#         --learner_type prompt --learner_name L2P \
#         --prompt_param 30 20 -1 \
#         --log_dir ${OUTDIR}/l2p++ \
#         --target_lab $i 
# done