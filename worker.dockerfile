## Build
FROM golang:latest AS build

WORKDIR /app

# Install dependencies
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy source code
COPY ./cmd/worker ./

# Build the binary
RUN go build -o /worker

## Deploy
FROM scratch

COPY --from=build /worker /worker

# Run the binary
ENTRYPOINT ["/worker"]
