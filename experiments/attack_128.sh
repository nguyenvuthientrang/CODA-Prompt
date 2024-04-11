# bash experiments/cifar-100.sh
# experiment settings
DATASET=cifar-100
N_CLASS=200

# save directory

# hard coded inputs
GPUID='0 1 3 4'
CONFIG=configs/attack_128.yaml
REPEAT=1
OVERWRITE=0

###############################################################

i=2
OUTDIR=outputs_128/${DATASET}/poison-10-task-target-$i
mkdir -p $OUTDIR

python3 -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
    --learner_type prompt --learner_name CODAPrompt \
    --prompt_param 100 8 0.0 \
    --log_dir ${OUTDIR}/coda-p \
    --target_lab $i

python3 -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
    --learner_type prompt --learner_name L2P \
    --prompt_param 30 20 -1 \
    --log_dir ${OUTDIR}/l2p++ \
    --target_lab $i 

python -u run.py --config $CONFIG --gpuid $GPUID --repeat $REPEAT --overwrite $OVERWRITE \
    --learner_type prompt --learner_name DualPrompt \
    --prompt_param 10 20 6 \
    --log_dir ${OUTDIR}/dual-prompt \
    --target_lab $i 

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