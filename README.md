## Cloud Run Demo

First let's try to deploy the demo manually

### Manually Deploy App to Cloudrun

We can use an example from [Quickstart: Build and Deploy](https://cloud.google.com/run/docs/quickstarts/build-and-deploy). After you created the following folder structure:

```bash
> tree
.
├── Makefile
├── README.md
└── app
    ├── Dockerfile
    └── app.py

1 directory, 4 files
```

Now let's submit a job to cloud build to create our docker image:

```bash
> export PROJECT_ID=$(gcloud info --format='value(config.project)')
> cd app
> gcloud builds submit --tag gcr.io/${PROJECT_ID}/flask:cloudrun-v1
Creating temporary tarball archive of 3 file(s) totalling 1.1 KiB before compression.
Uploading tarball of [.] to [gs://GCP_PROJECT_cloudbuild/source/1588196873.799832-f1128bb8107f467abc070127d58a5e95.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/GCP_PROJECT/builds/c96bf539-578d-4051-9ec2-1efc2a8639cb].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/c96bf539-578d-4051-9ec2-1efc2a8639cb?project=1057850595212].
----------------------------- REMOTE BUILD OUTPUT ------------------------------
starting build "c96bf539-578d-4051-9ec2-1efc2a8639cb"

FETCHSOURCE
Fetching storage object: gs://GCP_PROJECT_cloudbuild/source/1588196873.799832-f1128bb8107f467abc070127d58a5e95.tgz#1588196874215363
Copying gs://GCP_PROJECT_cloudbuild/source/1588196873.799832-f1128bb8107f467abc070127d58a5e95.tgz#1588196874215363...
/ [1 files][  890.0 B/  890.0 B]
Operation completed over 1 objects/890.0 B.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  4.608kB
Step 1/6 : FROM python:3.7-slim
3.7-slim: Pulling from library/python
54fec2fa59d0: Pulling fs layer
cd3f35d84cab: Pulling fs layer
33749e8cff73: Pulling fs layer
db881777c340: Pulling fs layer
c677d2dff43d: Pulling fs layer
db881777c340: Waiting
c677d2dff43d: Waiting
cd3f35d84cab: Verifying Checksum
cd3f35d84cab: Download complete
db881777c340: Verifying Checksum
db881777c340: Download complete
c677d2dff43d: Verifying Checksum
c677d2dff43d: Download complete
33749e8cff73: Verifying Checksum
33749e8cff73: Download complete
54fec2fa59d0: Verifying Checksum
54fec2fa59d0: Download complete
54fec2fa59d0: Pull complete
cd3f35d84cab: Pull complete
33749e8cff73: Pull complete
db881777c340: Pull complete
c677d2dff43d: Pull complete
Digest: sha256:0f322e5066a6c5c643829739dc93ea8ab73204abdea63b15af700fe6efd2ce4f
Status: Downloaded newer image for python:3.7-slim
 ---> d7ee20941226
Step 2/6 : ENV APP_HOME /app
 ---> Running in 043b0d522305
Removing intermediate container 043b0d522305
 ---> 5d0c0ebb9eab
Step 3/6 : WORKDIR $APP_HOME
 ---> Running in a5739db289b5
Removing intermediate container a5739db289b5
 ---> 3dac0c270915
Step 4/6 : COPY . ./
 ---> 647eab413655
Step 5/6 : RUN pip install Flask gunicorn
 ---> Running in cb997ea87f45
Collecting Flask
  Downloading Flask-1.1.2-py2.py3-none-any.whl (94 kB)
Collecting gunicorn
  Downloading gunicorn-20.0.4-py2.py3-none-any.whl (77 kB)
Collecting itsdangerous>=0.24
  Downloading itsdangerous-1.1.0-py2.py3-none-any.whl (16 kB)
Collecting Werkzeug>=0.15
  Downloading Werkzeug-1.0.1-py2.py3-none-any.whl (298 kB)
Collecting click>=5.1
  Downloading click-7.1.2-py2.py3-none-any.whl (82 kB)
Collecting Jinja2>=2.10.1
  Downloading Jinja2-2.11.2-py2.py3-none-any.whl (125 kB)
Requirement already satisfied: setuptools>=3.0 in /usr/local/lib/python3.7/site-packages (from gunicorn) (46.1.3)
Collecting MarkupSafe>=0.23
  Downloading MarkupSafe-1.1.1-cp37-cp37m-manylinux1_x86_64.whl (27 kB)
Installing collected packages: itsdangerous, Werkzeug, click, MarkupSafe, Jinja2, Flask, gunicorn
Successfully installed Flask-1.1.2 Jinja2-2.11.2 MarkupSafe-1.1.1 Werkzeug-1.0.1 click-7.1.2 gunicorn-20.0.4 itsdangerous-1.1.0
Removing intermediate container cb997ea87f45
 ---> e5f259094ab3
Step 6/6 : CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app
 ---> Running in d906bab9aab0
Removing intermediate container d906bab9aab0
 ---> 8697e5aa503e
Successfully built 8697e5aa503e
Successfully tagged gcr.io/GCP_PROJECT/flask:cloudrun-v1
PUSH
Pushing gcr.io/GCP_PROJECT/flask:cloudrun-v1
The push refers to repository [gcr.io/GCP_PROJECT/flask]
45bfc26538b4: Preparing
2361e904d47a: Preparing
c70b776e0240: Preparing
715414420313: Preparing
dba4fa00b93a: Preparing
9f690547ed37: Preparing
6376837eded8: Preparing
c2adabaecedb: Preparing
9f690547ed37: Waiting
6376837eded8: Waiting
c2adabaecedb: Waiting
715414420313: Layer already exists
dba4fa00b93a: Layer already exists
9f690547ed37: Layer already exists
6376837eded8: Layer already exists
c2adabaecedb: Layer already exists
c70b776e0240: Pushed
2361e904d47a: Pushed
45bfc26538b4: Pushed
cloudrun-v1: digest: sha256:4ed521056cf9feb7fae4e45f79195ac1d9d83f48f17241b5f931b02e6c173f3a size: 1995
DONE
--------------------------------------------------------------------------------

ID                                    CREATE_TIME                DURATION  SOURCE                                                                                     IMAGES                                STATUS
c96bf539-578d-4051-9ec2-1efc2a8639cb  2020-04-29T21:47:54+00:00  27S       gs://GCP_PROJECT_cloudbuild/source/1588196873.799832-f1128bb8107f467abc070127d58a5e95.tgz  gcr.io/GCP_PROJECT/flask:cloudrun-v1  SUCCESS
```

Next let's deploy it:

```bash
> export REGION=us-east4
> > gcloud run deploy "flask" --image gcr.io/${PROJECT_ID}/flask:cloudrun-v1 --region ${REGION} --platform managed --allow-unauthenticated
Deploying container to Cloud Run service [flask] in project [elatov-demo] region [us-east4]
✓ Deploying new service... Done.
  ✓ Creating Revision... Initializing project for the current region.
  ✓ Routing traffic...
  ✓ Setting IAM Policy...
Done.
Service [flask] revision [flask-00001-giv] has been deployed and is serving 100 percent of traffic at https://flask-iog62mnhaa-uk.a.run.app
```

You can confirm the deployment is working:

```bash
> curl https://flask-iog62mnhaa-uk.a.run.app
Hello World, my name is flask and I am running on cloud run
```

### Using Cloud Build to Auto deploy to Cloud Run
There are already some nice instructions in [Deploying to Cloud Run](https://cloud.google.com/cloud-build/docs/deploying-builds/deploy-cloud-run). I ended up creating a `cloudbuild.yaml` which builds and updates the deployment triggered by a push to a repository. For example if I made this change:

```bash
git diff
```

and pushed (don't forget to configure the [Required IAM permissions](https://cloud.google.com/cloud-build/docs/deploying-builds/deploy-cloud-run#required_iam_permissions)):

```bash
git push
```

I would see a build kicked off and I could also check out the logs of the build:

```bash
```

And after the build is finished I can confirm the new version is deployed:

```bash
```
