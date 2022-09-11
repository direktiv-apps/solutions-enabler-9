FROM golang:1.18.2-alpine as build

WORKDIR /src

COPY build/app/go.mod go.mod
COPY build/app/go.sum go.sum

RUN go mod download

COPY build/app/cmd cmd/
COPY build/app/models models/
COPY build/app/restapi restapi/

ENV CGO_LDFLAGS "-static -w -s"

RUN go build -tags osusergo,netgo -o /application cmd/solutions-enabler9-server/main.go; 

FROM opensuse/leap:15.3

RUN zypper -n install zsh glibc-32bit gcc-32bit tar git sudo hostname \
        man wget libopenssl-devel-32bit python-pip python3-pip vim strace \
            curl ca-certificates-mozilla gzip

RUN mkdir /dl
WORKDIR /dl
RUN wget https://dl.dell.com/downloads/DL103449_Solutions-Enabler-9.2.3.4-for-Linux-x64.gz

RUN tar -xvzf DL103449_Solutions-Enabler-9.2.3.4-for-Linux-x64.gz
RUN ls -la
RUN ./se9234_install.sh -install -silent

WORKDIR /

RUN find / | grep netcnfg
# RUN cat /usr/emc/API/symapi/config/netcnfg
RUN echo 1 && cat /usr/emc/API/symapi/config/README.netcnfg

ENV PATH $PATH:/opt/emc/SYMCLI/bin
ENV SYMCLI_OFFLINE 1

# install xml to json capability
RUN pip install yq
RUN zypper -n install jq

# DON'T CHANGE BELOW 
COPY --from=build /application /bin/application

EXPOSE 8080

CMD ["/bin/application", "--port=8080", "--host=0.0.0.0", "--write-timeout=0"]