#!/bin/bash
# Set up Node.js development environment

# Ensure we're in the Node workspace
cd /home/developer/dev/node

# Initialize package.json with default values
npm init -y

# Install common development dependencies
npm install --save-dev \
    typescript@latest \
    ts-node@latest \
    @types/node@latest \
    jest@latest \
    @types/jest@latest \
    ts-jest@latest \
    eslint@latest \
    @typescript-eslint/parser@latest \
    @typescript-eslint/eslint-plugin@latest \
    prettier@latest

# Create TypeScript configuration
cat > tsconfig.json << EOL
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "lib": ["ES2022"],
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.test.ts"]
}
EOL

# Create Jest configuration
cat > jest.config.js << EOL
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  testMatch: ['**/*.test.ts'],
  collectCoverage: true,
  coverageDirectory: 'coverage',
};
EOL

# Create ESLint configuration
cat > .eslintrc.js << EOL
module.exports = {
  parser: '@typescript-eslint/parser',
  extends: [
    'plugin:@typescript-eslint/recommended',
  ],
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: 'module',
  },
  rules: {},
};
EOL

# Create Prettier configuration
cat > .prettierrc << EOL
{
  "semi": true,
  "trailingComma": "all",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2
}
EOL

# Create project structure
mkdir -p {src,tests}

# Create example TypeScript file
cat > src/example.ts << EOL
export function greet(name: string): string {
  return \`Hello, \${name}!\`;
}
EOL

# Create example test file
cat > tests/example.test.ts << EOL
import { greet } from '../src/example';

describe('greet', () => {
  it('should return greeting with name', () => {
    expect(greet('World')).toBe('Hello, World!');
  });
});
EOL

# Update package.json scripts
npm pkg set scripts.build="tsc" \
    scripts.test="jest" \
    scripts.lint="eslint . --ext .ts" \
    scripts.format="prettier --write \"src/**/*.ts\" \"tests/**/*.ts\""

# Set correct ownership
chown -R developer:developer /home/developer/dev/node