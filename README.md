# FindCode Scanner GitHub Action

这个 Action 使用 FindCode 工具扫描 Go 代码中的 API 定义，支持 trpc、go_swagger 和 gin 框架。

## 使用方法

```yaml
jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - name: 检出代码
        uses: actions/checkout@v4
      
      - name: 运行 FindCode 扫描
        id: findcode
        uses: your-username/findcode-action@v1  # 替换为你的仓库和版本
        with:
          code_type: 'go_swagger'  # 可选值: trpc/go_swagger/gin
          go_target: './path/to/code'  # 目标代码路径
      
      - name: 上传报告
        uses: actions/upload-artifact@v3
        with:
          name: findcode-report
          path: ${{ steps.findcode.outputs.report-path }}