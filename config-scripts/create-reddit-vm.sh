#!/bin/bash
gcloud compute instances create reddit-app-test1\
                                                                --boot-disk-size=12GB \
                                                                --image-family reddit-full \
                                                                --image-project=infra-201811 \
                                                                --machine-type=g1-small \
                                                                --zone europe-west1-b \
                                                                --tags puma-server \
                                                                --restart-on-failur

