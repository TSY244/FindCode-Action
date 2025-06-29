#!/bin/bash

# 从GitHub Action获取输入参数
TARGET_PATH="$1"
CODE_TYPE="$2"
OUTPUT_REPORT="$3"
TARGET_CODE="$4"

# 确定使用的规则文件
case "$CODE_TYPE" in
    "trpc")
        RULE_FILE="rule/find_trpc_api.yaml"
        ;;
    "gin")
        RULE_FILE="rule/find_gin_api.yaml"
        ;;
    "go_swagger")
      RULE_FILE="rule/find_go_swagger_api.yaml"
      ;;
    *)
        RULE_FILE="rule/find_go_swagger_api.yaml"
        ;;
esac

# 创建输出目录（如果不存在）
mkdir -p "$(dirname "$OUTPUT_REPORT")"

# 执行FindCode扫描
echo "执行FindCode扫描..."
echo "目标代码路径: $TARGET_PATH"
echo "代码类型: $CODE_TYPE"
echo "使用规则文件: $RULE_FILE"
echo "输出报告路径: $OUTPUT_REPORT"

./FindCode -l "$TARGET_PATH" -r "$RULE_FILE" -o "$OUTPUT_REPORT" -go_target "$TARGET_CODE"

# 检查执行状态
if [ $? -eq 0 ]; then
    echo "FindCode扫描完成，报告已生成在: $OUTPUT_REPORT"
    exit 0
else
    echo "FindCode扫描失败"
    exit 1
fi