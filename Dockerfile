FROM golang:alpine as builder

RUN apk update && apk add --no-cache git

WORKDIR /src/app/
COPY . .

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" main.go

FROM scratch
COPY --from=builder /src/app/main /app/main
ENTRYPOINT ["/app/main"]