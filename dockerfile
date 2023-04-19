FROM golang:alpine as builder

WORKDIR /home/amadeu/fullcycle

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
#COPY go.mod  ./
#RUN go mod download && go mod verify

COPY . .
RUN go build -v -o /usr/local/bin/fullcycle ./...
RUN go clean -cache

FROM scratch
COPY --from=builder /usr/local/bin/fullcycle /fullcycle

CMD "go" "run" "."