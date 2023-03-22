FROM golang:1.20 AS builder
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
WORKDIR /app/web
RUN CGO_ENABLED=0 go build

FROM gcr.io/distroless/static-debian11
COPY --from=builder /app/web/web /app/web/web
ENTRYPOINT ["/app/web/web"]
