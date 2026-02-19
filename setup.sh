#!/bin/bash

echo "=========================================="
echo "Weekly Activity Report - Setup Script"
echo "=========================================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null
then
    echo "❌ Node.js tidak ditemukan. Silakan install Node.js terlebih dahulu."
    echo "Download dari: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js version: $(node --version)"
echo "✅ npm version: $(npm --version)"
echo ""

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
npm install
if [ $? -eq 0 ]; then
    echo "✅ Frontend dependencies installed successfully"
else
    echo "❌ Failed to install frontend dependencies"
    exit 1
fi

echo ""

# Install backend dependencies
echo "📦 Installing backend dependencies..."
npm install express pg cors dotenv
if [ $? -eq 0 ]; then
    echo "✅ Backend dependencies installed successfully"
else
    echo "❌ Failed to install backend dependencies"
    exit 1
fi

echo ""

# Create .env file if not exists
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cp .env.example .env
    echo "⚠️  Please edit .env file with your database credentials"
else
    echo "ℹ️  .env file already exists"
fi

echo ""
echo "=========================================="
echo "✅ Setup completed successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Edit .env file with your database configuration"
echo "2. Run 'node server.js' to start backend server"
echo "3. Run 'npm run dev' to start frontend development server"
echo ""
echo "Or run both with: npm run dev:all (after installing concurrently)"
echo ""
