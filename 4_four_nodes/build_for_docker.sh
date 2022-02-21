# update the resource limit in docker Desktop app
# OS: mac
# binary: for ubuntu platform


rm -rf $GOPATH/bin/teleport_ubuntu

docker run -it -v $GOPATH:/root/go -v $GOPATH/pkg:/go/pkg arm64v8/golang /bin/bash -c "cd /root/go/src/github.com/teleport-network/teleport && make install && mv /go/bin/teleport /root/go/bin/teleport_ubuntu"
