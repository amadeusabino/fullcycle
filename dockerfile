FROM golang:1.20.3

WORKDIR /home/amadeu/fullcycle

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod  ./
RUN go mod download && go mod verify

COPY . .
RUN go build -v -o /usr/local/bin/fullcycle ./...

CMD "go" "run" "."