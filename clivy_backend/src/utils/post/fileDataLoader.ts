import AWS from "aws-sdk";
import DataLoader from "dataloader";
import { PRIVATE_KEY } from "../cloudfrontKeys";
import { FileResponse } from "../global/globalInput";


export const fileDataLoader = () => 
new DataLoader<string, FileResponse>(async (fileKeys) => {
	const cloudfront = new AWS.CloudFront.Signer('K3D1IQ9SZ0X79C', PRIVATE_KEY);
	const fileResponses: any[] = [];
	await fileKeys.forEach( async (key) => {
		const filePromise = new Promise((resolve) => {
			cloudfront.getSignedUrl({
				// remember to add version to the key in user table in db
				url: 'https://d20af6jrxb8p1.cloudfront.net/' + key,
				expires: Math.floor(new Date().getTime() / 1000) + (60 * 60 * 24 * 2)
			}, (err, url) => {
				// console.log(url);
				if (err) {
					resolve({
						key: key,
						file: {
							error: 'could not load image'
						}
					});
				}
				resolve({
					key: key,
					file: {
						file: url
					}
				});
			});
		});
		await filePromise.then((file) => {
			fileResponses.push(file);
		});
	})

	const fileResponseMap: Record<string, FileResponse> = {};

	fileResponses.forEach((fileRes) => {
		fileResponseMap[fileRes.key] = fileRes.file;
	});

	return fileKeys.map(fileKey => fileResponseMap[fileKey]);
});