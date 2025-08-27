<!-- # Example application configuration for different frameworks

## For Node.js/Express Application
```javascript
// config/storage.js
const AWS = require('aws-sdk');

const s3Config = {
  bucket: process.env.S3_BUCKET_NAME, // Get from Terraform output
  region: process.env.AWS_REGION || 'us-east-1',
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  cdnUrl: process.env.CLOUDFRONT_URL // CloudFront URL for serving images
};

const s3 = new AWS.S3({
  accessKeyId: s3Config.accessKeyId,
  secretAccessKey: s3Config.secretAccessKey,
  region: s3Config.region
});

// Upload function
const uploadToS3 = async (file, fileName) => {
  const params = {
    Bucket: s3Config.bucket,
    Key: `images/${fileName}`,
    Body: file.buffer,
    ContentType: file.mimetype,
    ACL: 'public-read',
    Tagging: 'public=true' // Required for the bucket policy
  };

  try {
    const result = await s3.upload(params).promise();
    return {
      success: true,
      url: `${s3Config.cdnUrl}/images/${fileName}`,
      s3Url: result.Location
    };
  } catch (error) {
    throw new Error(`Upload failed: ${error.message}`);
  }
};

module.exports = { uploadToS3, s3Config };
```

## Environment Variables
```bash
# .env file
S3_BUCKET_NAME=your-bucket-name-from-terraform-output
AWS_REGION=us-east-1
CLOUDFRONT_URL=https://your-cloudfront-domain.cloudfront.net
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
```

## For Python/Django Application
```python
# settings.py
import os
import boto3
from botocore.exceptions import NoCredentialsError

# AWS S3 Configuration
AWS_ACCESS_KEY_ID = os.environ.get('AWS_ACCESS_KEY_ID')
AWS_SECRET_ACCESS_KEY = os.environ.get('AWS_SECRET_ACCESS_KEY')
AWS_STORAGE_BUCKET_NAME = os.environ.get('S3_BUCKET_NAME')
AWS_S3_REGION_NAME = os.environ.get('AWS_REGION', 'us-east-1')
AWS_S3_CUSTOM_DOMAIN = os.environ.get('CLOUDFRONT_URL', '').replace('https://', '')

# S3 Client
s3_client = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    region_name=AWS_S3_REGION_NAME
)

# Upload function
def upload_to_s3(file, file_name):
    try:
        s3_client.upload_fileobj(
            file,
            AWS_STORAGE_BUCKET_NAME,
            f'images/{file_name}',
            ExtraArgs={
                'ACL': 'public-read',
                'ContentType': file.content_type,
                'Tagging': 'public=true'
            }
        )
        return f"https://{AWS_S3_CUSTOM_DOMAIN}/images/{file_name}"
    except NoCredentialsError:
        raise Exception("AWS credentials not found")
```

## For React/Frontend Application
```javascript
// utils/upload.js
import axios from 'axios';

const uploadImage = async (file) => {
  const formData = new FormData();
  formData.append('image', file);

  try {
    const response = await axios.post('/api/upload', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    
    return response.data.url; // URL from CloudFront
  } catch (error) {
    throw new Error(`Upload failed: ${error.message}`);
  }
};

export { uploadImage };
```

## Docker Environment Variables
```dockerfile
# In your Dockerfile or docker-compose.yml
ENV S3_BUCKET_NAME=${S3_BUCKET_NAME}
ENV AWS_REGION=${AWS_REGION}
ENV CLOUDFRONT_URL=${CLOUDFRONT_URL}
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
``` -->
