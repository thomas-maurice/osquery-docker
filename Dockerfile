FROM ubuntu:latest

ENV OSQUERY_KEY=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install apt-transport-https ca-certificates gnupg -y
RUN echo "deb [arch=amd64] https://pkg.osquery.io/deb deb main" | tee /etc/apt/sources.list.d/osquery.list
RUN mkdir $HOME/.gnupg && \
    chmod 700 $HOME/.gnupg && \
    echo standard-resolver >> $HOME/.gnupg/dirmngr.conf && \
    gpg --no-tty --batch --recv-keys ${OSQUERY_KEY} && \
    gpg -a --export ${OSQUERY_KEY} | apt-key add -
RUN apt-get update && \
    apt-get install osquery -y
