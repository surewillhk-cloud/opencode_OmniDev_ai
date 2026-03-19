---
name: dev-standards
description: |
  Full-stack development standards including code principles, React/Next.js best practices,
  AI Studio prototype normalization, file structures, and API response formats.
  v5.2: 新增 API 冒烟测试要求、Zod 验证标准。
  Used by fullstack-dev and code-generator agents.
license: MIT
compatibility: opencode
metadata:
  keywords: "开发,代码,React,Next.js,API,开发标准"
---

# Development Standards v5.2

## 核心原则

- **DRY**: Don't Repeat Yourself - 提取公共逻辑
- **KISS**: Keep It Simple - 避免过度设计
- **Single Responsibility**: 一个函数做一件事，>50 行拆分
- **YAGNI**: You Aren't Gonna Need It - 不为未来构建

---

## 🔥 API 开发标准（必须遵守）

### 标准响应格式

```typescript
// 成功
{
  success: true,
  data: T
}

// 失败
{
  success: false,
  error: {
    code: string;    // 'VALIDATION_ERROR' | 'NOT_FOUND' | 'UNAUTHORIZED'
    message: string; // 用户可读消息
    details?: any    // 可选调试信息
  }
}
```

### API 文件模板

```typescript
// routes/[feature].ts
import { Router } from 'express';
import { z } from 'zod';  // 必须使用 zod 验证

const router = Router();

// 输入验证 Schema
const CreateSchema = z.object({
  name: z.string().min(1).max(100),
  email: z.string().email(),
});

// POST /api/[feature]
router.post('/', async (req, res) => {
  try {
    // 1. 验证输入
    const validated = CreateSchema.safeParse(req.body);
    if (!validated.success) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'VALIDATION_ERROR',
          message: '输入验证失败',
          details: validated.error.issues
        }
      });
    }

    // 2. 业务逻辑
    // const result = await createFeature(validated.data);

    // 3. 返回成功响应
    return res.status(201).json({
      success: true,
      data: result
    });

  } catch (err) {
    // 4. 错误处理
    console.error('[Feature] Create error:', err);
    return res.status(500).json({
      success: false,
      error: {
        code: 'INTERNAL_ERROR',
        message: '服务器内部错误'
      }
    });
  }
});

export default router;
```

### API 冒烟测试流程

每个 API 创建/修改后必须执行：

```bash
# 1. 启动服务器
npm run dev &

# 2. 等待就绪
sleep 3

# 3. curl 测试
curl -X POST http://localhost:3000/api/[feature] \
  -H "Content-Type: application/json" \
  -d '{"name":"Test","email":"test@example.com"}'

# 4. 验证响应格式
# 必须匹配：{success: boolean, data?: any, error?: {code, message}}
```

**重要**：只有 curl 测试通过后才能继续开发。

---

## React/Next.js 最佳实践

### 关键（必须修复）

#### 1. 消除瀑布流

**问题**：顺序数据获取
```typescript
// ❌ BAD - 瀑布流
const user = await fetchUser(id);
const posts = await fetchPosts(user.id);
const comments = await fetchComments(posts[0].id);
```

**解决方案**：并行或预加载
```typescript
// ✅ GOOD - 并行
const [user, posts] = await Promise.all([
  fetchUser(id),
  fetchPosts(id)
]);

// ✅ GOOD - 预加载
const postsQuery = useQuery({ queryKey: ['posts', id], queryFn: () => fetchPosts(id) });
const userQuery = useQuery({ queryKey: ['user', id], queryFn: () => fetchUser(id) });
```

#### 2. 优化打包大小

- 使用 dynamic imports 加载重组件
- 避免大库，使用替代品
- Tree-shake 未使用代码
```typescript
// ❌ BAD
import _ from 'lodash';

// ✅ GOOD - 精确导入
import debounce from 'lodash/debounce';

// ✅ BETTER - 使用原生或更小的库
import { debounce } from 'es-toolkit';
```

#### 3. 服务端渲染

- 在服务端渲染初始数据
- 默认使用 Server Components
- 最小化客户端打包
```typescript
// ❌ BAD - 客户端获取
'use client';
export default function Page({ params }) {
  const data = useQuery(['data'], () => fetch('/api/data'));
}

// ✅ GOOD - 服务端组件
export default async function Page({ params }) {
  const data = await fetch('/api/data', { cache: 'no-store' });
  return <Display data={data} />;
}
```

### 高优先级

#### 4. 客户端数据获取

- 使用 React Query / SWR 获取客户端数据
- 设置适当的 stale times
- 悬停时预获取
```typescript
// ✅ GOOD - React Query
const { data, isLoading } = useQuery({
  queryKey: ['user', userId],
  queryFn: () => fetchUser(userId),
  staleTime: 5 * 60 * 1000,
});
```

#### 5. 渲染优化

- 对昂贵计算使用 memoize
- 对列表项使用 React.memo
- 避免 props 内联函数
```typescript
// ❌ BAD
<List items={items} onItemClick={(id) => handleClick(id)} />

// ✅ GOOD
const handleClick = useCallback((id: string) => {
  // handler
}, [dep]);

<List items={items} onItemClick={handleClick} />
```

#### 6. 图片优化

- 始终指定尺寸
- 使用 next/image
- 懒加载折叠以下内容
```typescript
// ❌ BAD
<img src="/banner.png" />

// ✅ GOOD
import Image from 'next/image';
<Image src="/banner.png" width={800} height={400} alt="Banner" />
```

### 中优先级

#### 7. 适当的状态管理

- 简单 UI 状态使用 useState
- 全局状态使用 Context
- 服务端状态使用 React Query
- 避免 prop drilling

#### 8. 表单处理

- 使用受控组件
- blur 时验证，不是 change 时
- 提交尝试后显示错误
- 复杂表单使用 react-hook-form

---

## AI Studio 原型规范化

当从 `prototypes/[feature]/` 接收原型代码时：

### ✅ 保留（不动）
- UI 布局结构
- 交互逻辑和状态管理
- 视觉样式（颜色、间距、字体）
- 组件行为

### 🔧 必须转换
- [ ] 按项目结构拆分组件
- [ ] 内联样式替换为 Tailwind classes
- [ ] 添加 TypeScript 类型定义
- [ ] 提取 mock 数据到 `/mocks` 目录
- [ ] 添加 Loading 骨架屏
- [ ] 添加 Empty 空状态
- [ ] 添加 Error 错误状态
- [ ] 添加移动端响应式
- [ ] 替换 API 调用为真实端点占位符

### ❌ 禁止
- 重写 UI 结构
- 重写交互逻辑（除 Bug 外）
- 改变设计风格
- 丢弃 mock 数据

---

## 文件结构

### React / Next.js
```
app/[feature]/
  page.tsx
  layout.tsx
  loading.tsx
  error.tsx
  components/
    FeatureList.tsx
    FeatureItem.tsx
  hooks/
    useFeature.ts
  types.ts
  mocks/feature.mock.ts
```

### Node.js Backend
```
src/
  routes/
    feature.ts
  services/
    feature.service.ts
  middleware/
  types/
  utils/
```

### Python FastAPI
```
app/
  routers/
    feature.py
  services/
    feature.py
  schemas/
  models/
```

---

## 禁止行为

- ❌ API 没有错误处理
- ❌ 异步操作没有 Loading 状态
- ❌ TypeScript 使用 `any` 类型
- ❌ 硬编码密钥（使用环境变量）
- ❌ 全表查询无分页
- ❌ 控制器直接访问数据库
- ❌ 瀑布流数据获取
- ❌ 大库导入
- ❌ 未优化图片
- ❌ API 不使用 Zod 验证
- ❌ 跳过 API 冒烟测试
