FROM python:3-alpine

ARG MAINTAINER="<author>"
ARG VERSION="0.0.0-dev.0-build.0"

LABEL maintainer="${MAINTAINER}" \
      version="${VERSION}"

LABEL MAINTAINER='<author>'
LABEL VERSION='0.0.0-dev.0-build.0'

ADD . /code
WORKDIR /code
RUN \
  apk add --no-cache libc-dev libffi-dev gcc && \
  pip install -r requirements.txt --no-cache-dir && \
  apk del gcc libc-dev libffi-dev && \
  addgroup webssh && \
  adduser -Ss /bin/false -g webssh webssh && \
  chown -R webssh:webssh /code

EXPOSE 8888/tcp
USER webssh
ENTRYPOINT ["python", "run.py"]
