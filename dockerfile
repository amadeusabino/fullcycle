FROM golang:alpine as builder

WORKDIR /home/amadeu/fullcycle

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY . /home/amadeu/fullcycle  
#RUN go mod download && go mod verify

#COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /usr/local/bin/fullcycle fullcycle.go
RUN go clean -cache

FROM scratch
COPY --from=builder /usr/local/bin/fullcycle ./

CMD ["./fullcycle"]