const express = require('express');
const axios = require('axios');
const path = require('path');

const app = express();
const PORT = 3000;

// 中间件
app.use(express.json());
app.use(express.static(__dirname));

// 代理接口：查询tag生成时间
app.post('/api/tag-generate-time', async (req, res) => {
    try {
        const { tag } = req.body;
        
        const response = await axios.post(
            'http://search.fly.17usoft.com/wechatcore/slim/SearchSnapshotGenerateTime',
            { tag },
            {
                headers: {
                    'Content-Type': 'application/json'
                },
                timeout: 10000
            }
        );

        res.json(response.data);
    } catch (error) {
        console.error('查询tag生成时间失败:', error.message);
        res.status(500).json({
            IsSuccess: false,
            ErrorMsg: error.message
        });
    }
});

// 代理接口：查询天网日志
app.post('/api/skynet-logs', async (req, res) => {
    try {
        const response = await axios.post(
            'http://skynetapi.dss.17usoft.com/log/real/list',
            req.body,
            {
                headers: {
                    'Content-Type': 'application/json',
                    ...(req.body.tokens && req.body.tokens.length > 0 ? { 'token': req.body.tokens.join(',') } : {})
                },
                timeout: 30000
            }
        );

        res.json(response.data);
    } catch (error) {
        console.error('查询天网日志失败:', error.message);
        res.status(500).json({
            code: 500,
            message: error.message
        });
    }
});

// 启动服务器
app.listen(PORT, () => {
    console.log(`服务器运行在 http://localhost:${PORT}`);
    console.log(`按 Ctrl+C 停止服务器`);
});
