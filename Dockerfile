# 第一阶段：构建FindCode
FROM golang:latest AS builder
WORKDIR /app

RUN apt-get update && apt-get install -y git
# 直接克隆到当前目录，避免嵌套
RUN git clone https://github.com/TSY244/FindCode.git .

#COPY FindCode/ .


RUN make build_cmd

# 第二阶段：创建运行时环境
FROM ubuntu:latest AS runtime
WORKDIR /app
RUN apt-get update && apt-get install -y bash

COPY --from=builder /app/FindCode .
COPY --from=builder /app/etc /app/etc
COPY --from=builder /app/rule /app/rule
COPY --from=builder /app/run_with_action.sh .
RUN chmod +x FindCode
RUN chmod +x /app/run_with_action.sh
ENTRYPOINT ["/app/run_with_action.sh"]