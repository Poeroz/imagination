exp=multi30k_en_fr
fairseq-train data-bin/multi30k_en_fr --task translation \
--arch transformer_multi30k_en_fr --share-all-embeddings --dropout 0.1 \
--optimizer adam --adam-betas '(0.9, 0.98)' --clip-norm 0.0 \
--lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 --warmup-updates 4000 \
--lr 0.0007 --min-lr 1e-09 \
--criterion label_smoothed_cross_entropy --label-smoothing 0.1 --weight-decay 0.0 \
--max-tokens 4096 \
--update-freq 8 --no-progress-bar --log-format json --log-interval 100 \
--save-interval-updates 1000 \
--keep-last-epochs 5 --keep-interval-updates 10 \
--save-dir checkpoints/$exp \
--ddp-backend=no_c10d \
--left-pad-source False \
--no-epoch-checkpoints \
--eval-bleu \
--eval-bleu-args '{"beam": 5, "lenpen": 0.6}' \
--eval-bleu-detok moses \
--eval-bleu-remove-bpe \
--eval-bleu-print-samples \
--best-checkpoint-metric bleu --maximize-best-checkpoint-metric \
--max-update 10000 | tee logs/$exp.txt