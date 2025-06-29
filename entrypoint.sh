#!/bin/sh -l

# 获取输入参数
CODE_TYPE=$1
GO_TARGET=$2
REPORT_PATH=$3

# 根据 code_type 选择规则文件
case $CODE_TYPE in
  "trpc")
    RULE_FILE="/FindCode/rule/find_trpc_api.yaml"
    ;;
  "go_swagger")
    RULE_FILE="/FindCode/rule/find_go_swagger_api.yaml"
    ;;
  "gin")
    RULE_FILE="/FindCode/rule/find_gin_api.yaml"
    ;;
  *)
    echo "不支持的代码框架类型: $CODE_TYPE" >&2
    exit 1
    ;;
esac

# 执行扫描
cd /FindCode
./FindCode -l "$GO_TARGET" -r "$RULE_FILE" -o "$REPORT_PATH"

# 输出报告路径作为 Action 输出
echo "::set-output name=report-path::$REPORT_PATH"

# 打印完成信息
echo "扫描完成！报告已生成至: $REPORT_PATH"