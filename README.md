# CodeNexus v5.1 - AI-Driven Development Team

> LLM-powered code generation team built on OpenCode architecture
> 
> Architecture: Agent handles orchestration, Skill provides expertise - fully decoupled and independently replaceable.

---

## Directory Structure

```
project-root/
  AGENTS.md                    ← Global rules + workflow controller
  opencode.json                ← OpenCode config (Agent permissions)
  CHANGELOG.md                 ← Auto-maintained
  .opencode/
    agent/                     ← 5 Core Agents
      orchestrator.md          ← Workflow orchestration
      product-manager.md       ← Requirements analysis, PRD + CHANGELOG output
      ui-designer.md         ← UI design prompts (Figma/Imagen/AI Studio)
      fullstack-dev.md       ← Full-stack development (loads Skill by keywords)
      qa-tester.md           ← Testing + validation + iteration

    skills/                    ← 21 Skills (keyword-triggered)
      prd-methodology/         ← PRD writing standards
      changelog-format/       ← CHANGELOG format
      ui-figma-playbook/     ← Figma prompt guide
      ui-imagen-guide/       ← Imagen 4 guide
      ui-aistudio-guide/     ← AI Studio prompt guide
      dev-standards/         ← Code standards + prototype normalization
      test-checklist/        ← Testing checklist
      architecture-design/  ← Architecture design (keyword-triggered)
      code-generation/      ← Code generation (keyword-triggered)
      security-audit/       ← Security audit (keyword-triggered)
      devops-automation/    ← DevOps automation (keyword-triggered)
      code-refactoring/     ← Refactoring patterns (keyword-triggered)
      web-design-guidelines/← Web design best practices
      composition-patterns/ ← React composition patterns
      vercel-deploy/       ← Vercel deployment
      token-economics/     ← Token economics
      protocol-design/     ← Protocol design
      mvp-sequencing/     ← MVP development sequence (keyword-triggered)
      blockchain-standards/← Blockchain development (keyword-triggered)
      x-content-strategy/ ← X (Twitter) content strategy
      agent-creator/      ← Agent creation guide

  docs/                        ← AI-generated documentation
  prototypes/                  ← AI Studio prototype code
```

---

## Agent Team (5 Core Agents)

| Agent | Function | Trigger Keywords |
|-------|----------|------------------|
| **orchestrator** | Workflow orchestration, manages pipeline | workflow-related |
| **product-manager** | Requirements analysis, PRD output | "I want to build", "requirements" |
| **ui-designer** | UI design prompts generation | "UI", "design", "prototype" |
| **fullstack-dev** | Any code development task | "develop", "implement", "write code" |
| **qa-tester** | Testing, validation, quality assurance | "test", "verify" |

---

## Usage

### Method 1: Full Product Development (Auto Flow)

Simply describe requirements, system auto-schedules agents:

```
I want to build a user management system
```

Orchestrator auto-flows: product-manager → ui-designer → fullstack-dev → qa-tester

### Method 2: Direct Agent Invocation

Use `@agent-name` to invoke directly:

```
@product-manager I need a PRD for e-commerce system
@ui-designer Design product detail page UI
@fullstack-dev Implement shopping cart feature
@qa-tester Test checkout flow
```

### Method 3: Keyword-Triggered Skills (Auto Load)

No need to manually specify Skills - Agent auto-loads based on keywords:

| Request Example | Auto-loaded Skill |
|-----------------|-------------------|
| "Build a distributed architecture system" | `architecture-design` |
| "Write code with security audit" | `security-audit` |
| "Deploy to Vercel" | `devops-automation` |
| "Refactor this module" | `code-refactoring` |
| "Design blockchain settlement" | `blockchain-standards` |

### Method 4: Combined Usage

```
@fullstack-dev Build a trading system, deploy to Vercel, with security audit
```

fullstack-dev will auto-load `devops-automation` + `security-audit` Skills

---

## Skill Mapping

| Skill | Keywords | Purpose |
|-------|----------|---------|
| `prd-methodology` | PRD-related | PRD writing |
| `changelog-format` | CHANGELOG | Changelog maintenance |
| `ui-figma-playbook` | Figma | Figma prompts |
| `ui-imagen-guide` | Image generation | Imagen prompts |
| `ui-aistudio-guide` | Prototype | AI Studio prompts |
| `dev-standards` | Code development | Code standards |
| `test-checklist` | Test | Testing checklist |
| `architecture-design` | Architecture, tech stack | Architecture design |
| `code-generation` | Generate, create, implement | Code generation |
| `security-audit` | Security, vulnerability, audit | Security audit |
| `devops-automation` | Deploy, CI/CD, Docker | DevOps |
| `code-refactoring` | Refactor, optimize | Refactoring |
| `blockchain-standards` | Blockchain, smart contract | Blockchain dev |
| `mvp-sequencing` | MVP, roadmap | MVP planning |

---

## Decoupled Architecture

### Architecture Diagram

```
User Request
    ↓
[Keyword Detection] ←→ Skill Knowledge Base
    ↓
Orchestrator decides which Agent to invoke
    ↓
Agent executes task (auto-injects relevant Skill context)
```

### Benefits

- Want to change testing methodology → Just replace `test-checklist/SKILL.md`
- Want new language/framework → Just replace `code-generation/SKILL.md` + `dev-standards/SKILL.md`
- Want different security standards → Just replace `security-audit/SKILL.md`
- **Agent definitions remain unchanged**

---

## Agent Invocation Priority

### Simple Task (Quick Development)
```
@fullstack-dev → @qa-tester
```

### Full Product Development
```
@product-manager → @ui-designer → @fullstack-dev → @qa-tester
```

### Architecture + Development + Deployment
```
@product-manager → @ui-designer → @fullstack-dev (loads architecture-design + devops-automation) → @qa-tester
```

### Refactoring + Security Audit
```
@fullstack-dev (loads code-refactoring + security-audit) → @qa-tester
```

---

## Version History

| Version | Changes |
|---------|---------|
| v5.1 | Simplified to 5 core Agents, Skills added keyword-triggered decoupled loading |
| v5 | Added 5 LLM code generation Agents + 5 Skills |
| v4 | Agent + Skill decoupled architecture |
| v3 | Role-based hard switching |

---

## Installation

```bash
# Copy to new project
cp -r .opencode /your/project/path/
cp AGENTS.md /your/project/path/
cp opencode.json /your/project/path/
```

---

*Built on OpenCode Agent + Skill architecture | v5.1*
