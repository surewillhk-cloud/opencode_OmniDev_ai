#!/bin/bash
# API 冒烟测试脚本
# 用法: ./smoke-test.sh [BASE_URL]
# 默认 BASE_URL=http://localhost:3000

set -e

BASE_URL="${1:-http://localhost:3000}"
PASS=0
FAIL=0

echo "========================================"
echo "  API 冒烟测试"
echo "  目标: $BASE_URL"
echo "========================================"
echo ""

# 等待服务器就绪
echo "🔄 等待服务器就绪..."
for i in {1..10}; do
  if curl -s --fail "$BASE_URL/health" > /dev/null 2>&1; then
    echo "✅ 服务器就绪"
    break
  fi
  if [ $i -eq 10 ]; then
    echo "❌ 服务器未响应，请确保服务已启动"
    exit 1
  fi
  sleep 2
done

echo ""

# 测试函数
test_endpoint() {
  local method="$1"
  local endpoint="$2"
  local data="$3"
  local description="$4"
  local expected_status="${5:-200}"

  local full_url="$BASE_URL$endpoint"
  local response
  local status_code

  printf "测试: %-40s ..." "$description"

  if [ "$method" = "GET" ]; then
    response=$(curl -s -w "\n%{http_code}" "$full_url")
  else
    response=$(curl -s -w "\n%{http_code}" -X "$method" -H "Content-Type: application/json" -d "$data" "$full_url")
  fi

  status_code=$(echo "$response" | tail -n 1)
  body=$(echo "$response" | sed '$d')

  if [ "$status_code" = "$expected_status" ]; then
    # 验证响应格式
    if echo "$body" | grep -q '"success"'; then
      echo "✅ PASS (status: $status_code)"
      ((PASS++))
    else
      echo "⚠️  WARN (响应缺少 success 字段)"
      ((PASS++))
    fi
  else
    echo "❌ FAIL (expected: $expected_status, got: $status_code)"
    echo "   响应: $body"
    ((FAIL++))
  fi
}

# 测试用例
echo "========================================"
echo "  正向路径测试"
echo "========================================"

test_endpoint "GET" "/health" "" "健康检查" "200"
test_endpoint "GET" "/api/health" "" "API 健康检查" "200"

echo ""
echo "========================================"
echo "  验证失败测试"
echo "========================================"

test_endpoint "POST" "/api/users" '{"email":"invalid"}' "无效邮箱验证" "400"
test_endpoint "POST" "/api/users" '{"name":""}' "空名字验证" "400"

echo ""
echo "========================================"
echo "  认证测试（如适用）"
echo "========================================"

test_endpoint "GET" "/api/protected" "" "无认证访问" "401"

echo ""
echo "========================================"
echo "  测试结果"
echo "========================================"
echo "  ✅ 通过: $PASS"
echo "  ❌ 失败: $FAIL"
echo "========================================"

if [ $FAIL -gt 0 ]; then
  echo "❌ 冒烟测试失败"
  exit 1
else
  echo "✅ 冒烟测试全部通过"
  exit 0
fi
