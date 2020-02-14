# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Make will use bash instead of sh
SHELL := /usr/bin/env bash
PROJECT_ID := $(shell gcloud config list --format "value(core.project)")
IMAGE_NAME := gcr.io/${PROJECT_ID}/cloudrun
SVC_NAME := cloudrun
REG := us-east1

build-container:
	gcloud config configurations activate ${PROJECT_ID}
	cd app && gcloud builds submit --tag ${IMAGE_NAME} && echo -e "======="
	gcloud container images list-tags ${IMAGE_NAME} && echo -e "======="

deploy-app:
	gcloud config configurations activate ${PROJECT_ID}
	gcloud beta run deploy ${SVC_NAME} --image ${IMAGE_NAME} --platform managed --region ${REG} --allow-unauthenticated && echo -e "======="

URL := $(shell gcloud beta run services list --platform managed --format value'(status.address.hostname)')

generate-load:
	for i in $$(seq 1 100); do echo $$i; curl ${URL} ; done
	echo "visit https://console.cloud.google.com/run/detail/us-east1/${SVC_NAME}/metrics?project=${PROJECT_ID}"

cleanup:
	gcloud container images delete ${IMAGE_NAME} --force-delete-tags --quiet
	gcloud beta run services delete --platform managed ${SVC_NAME} --region ${REG} -q
