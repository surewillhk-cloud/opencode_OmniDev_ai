---
name: api-design
description: |
  REST API design standards and best practices. Use when: designing APIs, creating endpoints,
  defining request/response formats, or building API documentation.
license: MIT
compatibility: opencode
metadata:
  keywords: "API,REST,GraphQL,接口,端点,请求,响应,HTTP方法,状态码"
---

# API Design Skill

## 核心原则

1. **资源导向** - 使用名词而非动词
2. **标准状态码** - 正确使用 HTTP 状态码
3. **一致性** - 统一的命名和格式
4. **版本控制** - API 版本管理

---

## RESTful URL 设计

### URL 结构

```
/api/v1/{resource}/{id}/{sub-resource}
```

### HTTP 方法映射

| 方法 | 用途 | 示例 |
|------|------|------|
| GET | 获取资源 | `GET /api/v1/users` |
| GET | 获取单个资源 | `GET /api/v1/users/123` |
| POST | 创建资源 | `POST /api/v1/users` |
| PUT | 更新资源（全量）| `PUT /api/v1/users/123` |
| PATCH | 更新资源（部分）| `PATCH /api/v1/users/123` |
| DELETE | 删除资源 | `DELETE /api/v1/users/123` |

### 命名规范

- 使用**复数名词**：`/users` 而非 `/user`
- 使用** kebab-case**：`/user-profiles`
- 层级限制：**最多 3 层**，`/users/123/orders`

---

## 标准响应格式

### 成功响应

```json
{
  "success": true,
  "data": {
    "id": "123",
    "name": "张三",
    "email": "zhangsan@example.com"
  },
  "meta": {
    "page": 1,
    "pageSize": 20,
    "total": 100
  }
}
```

### 错误响应

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "输入验证失败",
    "details": [
      {
        "field": "email",
        "message": "邮箱格式不正确"
      }
    ]
  }
}
```

---

## HTTP 状态码

| 状态码 | 含义 | 使用场景 |
|--------|------|---------|
| 200 | OK | 成功获取/更新资源 |
| 201 | Created | 资源创建成功 |
| 204 | No Content | 删除成功（无返回体）|
| 400 | Bad Request | 请求参数错误 |
| 401 | Unauthorized | 未认证 |
| 403 | Forbidden | 无权限 |
| 404 | Not Found | 资源不存在 |
| 409 | Conflict | 资源冲突 |
| 422 | Unprocessable Entity | 验证失败 |
| 429 | Too Many Requests | 请求过于频繁 |
| 500 | Internal Server Error | 服务器错误 |

---

## 分页规范

### 标准分页参数

```
GET /api/v1/users?page=1&pageSize=20
```

### 响应包含

```json
{
  "data": [...],
  "meta": {
    "page": 1,
    "pageSize": 20,
    "total": 100,
    "totalPages": 5
  }
}
```

---

## 过滤、排序、搜索

### 查询参数规范

```
GET /api/v1/users?status=active&sort=createdAt:desc&search=zhang
```

| 参数 | 用途 | 示例 |
|------|------|------|
| `filter` | 过滤 | `filter[status]=active` |
| `sort` | 排序 | `sort=createdAt:desc` |
| `search` | 搜索 | `search=zhang` |
| `fields` | 字段选择 | `fields=id,name,email` |

---

## API 版本控制

### URL 版本

```
/api/v1/users
/api/v2/users
```

### 版本迁移策略

1. **共存** - v1 和 v2 同时提供服务
2. **废弃通知** - 旧版本显示警告 Header
3. **迁移期限** - 明确废弃时间表

---

## 认证与授权

### 认证 Header

```
Authorization: Bearer <token>
```

### 常见认证方案

| 方案 | 适用场景 |
|------|---------|
| Bearer Token (JWT) | API 认证 |
| API Key | 服务间调用 |
| OAuth 2.0 | 第三方授权 |

---

## 输入验证

### Zod Schema 示例

```typescript
import { z } from 'zod';

const CreateUserSchema = z.object({
  name: z.string().min(1).max(100),
  email: z.string().email(),
  age: z.number().int().min(0).max(150).optional(),
  role: z.enum(['admin', 'user']).default('user'),
});

type CreateUserInput = z.infer<typeof CreateUserSchema>;
```

---

## 禁止行为

- ❌ API 返回不一致的响应格式
- ❌ 使用非标准状态码
- ❌ 在 URL 中使用动词：`/getUsers`
- ❌ 嵌套超过 3 层
- ❌ 单复数混用

---

## API 文档要求

每个 API 必须包含：

1. **端点描述** - 做什么的
2. **请求参数** - 参数名、类型、必填、说明
3. **请求示例** - curl 或 HTTP 示例
4. **响应示例** - 成功和错误响应
5. **错误码表** - 所有可能的错误码

---

**版本：v1.0 | API 设计规范 | OpenCode 原生**
