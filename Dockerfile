FROM golang:1.20-buster

# 安装依赖
RUN apt-get update && apt-get install -y git make

# 克隆并编译 FindCode 工具
RUN git clone https://github.com/TSY244/FindCode.git /FindCode
WORKDIR /FindCode
RUN make build_cmd

# 设置工作目录
WORKDIR /github/workspace

# 复制入口脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 设置入口点
ENTRYPOINT ["/entrypoint.sh"]