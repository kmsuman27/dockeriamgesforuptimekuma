# 1. Base image का उपयोग करें
FROM node:24-slim

# 2. Python और C++ कंपाइलर टूल्स इनस्टॉल करें (npm install/build के लिए ज़रूरी)
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 3. वर्किंग डायरेक्टरी सेट करें
WORKDIR /app

# 4. पहले package.json कॉपी करें (कैशिंग का फ़ायदा उठाने के लिए)
COPY package*.json ./

# 5. डिपेंडेंसीज़ इनस्टॉल करें
RUN npm install

# 6. बाकी का सारा कोड कॉपी करें
COPY . .

# 7. प्रोजेक्ट को बिल्ड करें
RUN npm run build

# 8. पोर्ट एक्सपोज करें
EXPOSE 3001

# 9. सर्वर स्टार्ट करने का कमांड
CMD ["npm", "run", "start-server"]
