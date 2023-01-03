import AWS from "aws-sdk";

export const uploadImageToS3 = async (key: string, compressedBuffer: Buffer, contentType: string) => {

	const s3 = new AWS.S3({
		region: 'us-east-2',
	});

	const result = await new Promise((resolve) => {
		s3.upload({
			Bucket: '',
			Key: key,
			Body: compressedBuffer,
			ContentType: contentType,
			ContentEncoding: 'H.264'
		}, (err) => {
			if (err) {
				console.log('the error is: ' + err);
				resolve(false);
			}
			resolve(true)
		});
	});

  return result;
}