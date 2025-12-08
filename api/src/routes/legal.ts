
import express from 'express';
import path from 'path';
import fs from 'fs';
import { UAParser } from 'ua-parser-js';

const router = express.Router();

// List of known bot user agents and SEO crawlers
const BOT_PATTERNS = [
  /googlebot/i,
  /bingbot/i,
  /slurp/i, // Yahoo
  /duckduckbot/i,
  /baiduspider/i,
  /yandexbot/i,
  /facebookexternalhit/i,
  /twitterbot/i,
  /linkedinbot/i,
  /whatsapp/i,
  /telegrambot/i,
  /applebot/i,
  /crawler/i,
  /spider/i,
  /bot/i,
  /scraper/i,
  /chatgpt/i,
  /gpt/i,
  /claude/i,
  /anthropic/i,
  /openai/i
];

const accessDeniedError = 'Access denied';

// Function to detect if request is from a bot
const isBotRequest = (userAgent: string) => {
  if (!userAgent) return true; // No user agent = suspicious
  
  // Check against known bot patterns
  for (const pattern of BOT_PATTERNS) {
    if (pattern.test(userAgent)) {
      return true;
    }
  }
  
  // Parse user agent for additional bot detection
  const parser = new UAParser(userAgent);
  const result = parser.getResult();
  
  // Check if it's a known bot browser
  if (result.browser.name && /bot|crawler|spider/i.test(result.browser.name)) {
    return true;
  }
  
  // Check for suspicious OS (many bots don't report proper OS)
  if (!result.os.name || result.os.name === 'undefined') {
    return true;
  }
  
  return false;
};

// Vulnerable terms download endpoint
router.get('/terms/download', (req, res) => {
  try {
    const userAgent = req.get('User-Agent') || '';
    
    // Bot detection - block SEO crawlers and AI bots
    if (isBotRequest(userAgent)) {
      console.log(`🤖 Bot detected and blocked: ${userAgent}`);
      res.status(403).json({ 
        error: 'Access denied',
        message: 'Automated access to PDF downloads is not permitted',
        reason: 'Bot/crawler detected'
      });
      return;
    }
    
    console.log(`✅ Human user allowed: ${userAgent}`);
    
    const { file, lang = 'en' } = req.query;
    if (!file) {
      res.status(400).json({ error: 'File parameter is required' });
      return;
    }
    // VULNERABILITY: Direct path concatenation allows traversal
    const documentPath = path.join(__dirname, '../../documents/legal', lang as string, file as string);
    if (!fs.existsSync(documentPath)) {
      res.status(404).json({ error: 'Document not found' });
      return;
    }
    res.setHeader('Content-Disposition', `attachment; filename="${file}"`);
    res.setHeader('Content-Type', 'application/pdf');
    res.sendFile(documentPath);
  } catch (error) {
    console.error('Error in terms download:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// List available terms documents (mock data)
router.get('/terms', (req, res) => {
  const documents = [
    { id: 1, version: '2.1', filename: 'terms_v2.1.pdf', language: 'en', effectiveDate: '2024-01-01' },
    { id: 2, version: '2.1', filename: 'agb_v2.1.pdf', language: 'de', effectiveDate: '2024-01-01' },
    { id: 3, version: '2.0', filename: 'terms_v2.0.pdf', language: 'en', effectiveDate: '2023-06-01' }
  ];
  res.json(documents);
});

export default router;
