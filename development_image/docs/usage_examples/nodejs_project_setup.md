# Node.js Project Setup Guide

## Prerequisites
- Docker development environment is running
- SSH key has been uploaded to container
- Node.js 20.11.1 and npm are pre-installed

## Step 1: Create New Node.js Project

### Option A: Express.js API
```bash
# SSH into container
ssh developer@localhost -p 2222

# Create Express project
cd /home/developer/dev
mkdir express-api && cd express-api
npm init -y
npm install express cors helmet morgan dotenv
npm install -D nodemon

# Create basic server
cat > server.js << 'EOF'
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(helmet());
app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'Hello from Express API!' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
EOF

# Add dev script to package.json
npm pkg set scripts.dev="nodemon server.js"
```

### Option B: React Application
```bash
# SSH into container
ssh developer@localhost -p 2222

# Create React app
cd /home/developer/dev
npx create-react-app my-react-app
cd my-react-app
npm start
```

### Option C: Next.js Application
```bash
# SSH into container
ssh developer@localhost -p 2222

# Create Next.js app
cd /home/developer/dev
npx create-next-app@latest my-next-app --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"
cd my-next-app
npm run dev
```

## Step 2: VS Code Integration

### VS Code Remote SSH
1. Install "Remote - SSH" extension
2. Press F1 → "Remote-SSH: Connect to Host"
3. Enter: `developer@localhost:2222`
4. Open `/home/developer/dev/your-project`

## Step 3: Development Workflow

### Hot Reload Development
```bash
# For Express.js
npm run dev

# For React
npm start

# For Next.js
npm run dev
```

### Package Management
```bash
# Install dependencies
npm install

# Install specific package
npm install axios lodash

# Install dev dependencies
npm install -D jest @types/node

# Update packages
npm update
```

## Step 4: Debugging Setup

### VS Code Debug Configuration
Create `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Launch Express",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/server.js",
      "env": {
        "NODE_ENV": "development"
      }
    }
  ]
}
```

## Step 5: Testing

### Unit Tests with Jest
```bash
# Install Jest
npm install -D jest @types/jest

# Create test file
cat > server.test.js << 'EOF'
const request = require('supertest');
const app = require('./server');

describe('GET /', () => {
  it('should return hello message', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toEqual(200);
    expect(res.body).toHaveProperty('message');
  });
});
EOF

# Run tests
npm test
```

## Step 6: Environment Variables

### Create .env file
```bash
# Create environment file
cat > .env << 'EOF'
PORT=3000
NODE_ENV=development
DATABASE_URL=postgresql://user:pass@localhost:5432/mydb
JWT_SECRET=your-secret-key
EOF

# Add to .gitignore
echo ".env" >> .gitignore
```

## Step 7: TypeScript Setup

### Add TypeScript to Existing Project
```bash
# Install TypeScript
npm install -D typescript @types/node @types/express

# Initialize TypeScript config
npx tsc --init

# Create tsconfig.json
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
EOF
```

## Common Issues and Solutions

### Issue: Port Already in Use
```bash
# Check what's using the port
lsof -i :3000
# Kill process or use different port
PORT=3001 npm start
```

### Issue: Node Modules Permission
```bash
# Fix permissions
sudo chown -R developer:developer node_modules
```

### Issue: Memory Issues
```bash
# Increase Node.js memory limit
export NODE_OPTIONS="--max-old-space-size=4096"
```

### Issue: npm install hanging
```bash
# Clear npm cache
npm cache clean --force
# Use different registry
npm config set registry https://registry.npmjs.org/
```

## Performance Optimization

### Development Mode
```bash
# Use faster package manager
npm install -g pnpm
pnpm install

# Enable faster refresh
npm install -D @vitejs/plugin-react
```

### Production Build
```bash
# Build for production
npm run build

# Serve production build
npm install -g serve
serve -s build
```

## Next Steps
- Add ESLint and Prettier configuration
- Set up CI/CD pipeline
- Add Docker production deployment
- Configure monitoring and logging
