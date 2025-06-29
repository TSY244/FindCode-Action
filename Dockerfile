# 第一阶段：构建FindCode
FROM golang:latest AS builder
WORKDIR /app

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/TSY244/FindCode.git .
RUN make build_cmd

# 第二阶段：创建运行时环境
FROM ubuntu:latest AS runtime

# 创建非root用户和工作目录
RUN groupadd -g 1001 runner && \
    useradd -r -u 1001 -g runner runner && \
    mkdir -p /app && chown runner:runner /app

WORKDIR /app
USER runner

# 安装依赖并复制文件
RUN sudo apt-get update && sudo apt-get install -y bash
COPY --from=builder --chown=runner:runner /app/FindCode .
COPY --from=builder --chown=runner:runner /app/etc /app/etc
COPY --from=builder --chown=runner:runner /app/rule /app/rule
COPY --from=builder --chown=runner:runner /app/run_with_action.sh .

RUN chmod +x FindCode && chmod +x run_with_action.sh

ENTRYPOINT ["/app/run_with_action.sh"]