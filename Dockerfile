FROM golang:latest
WORKDIR /app
# 安装git
RUN apt-get update && apt-get install -y git
# 克隆FindCode代码
RUN git clone https://github.com/TSY244/FindCode.git
# 重新设置工作目录
WORKDIR /app/FindCode
# 安装依赖
RUN go mod tidy
# 执行编译
RUN make build_cmd
# 拷贝run.sh 到 /app
COPY run.sh .
# 可执行权限
RUN chmod +x FindCode
RUN chmod +x run.sh
# 设置入口点，以便运行扫描逻辑 将会拼接action 参数
ENTRYPOINT ["./app/FindCode/run.sh"]