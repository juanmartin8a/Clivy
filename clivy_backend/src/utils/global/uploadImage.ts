import { uploadImageToS3 } from "../aws/uploadToBucket";
import { getFileBuffer } from "./getFileBuffer";
import { ReadStream } from "fs-capacitor";

export const uploadFileProcess = async (createReadStream: () => ReadStream, key: string, contentType: string) => {
    const buffer = await getFileBuffer(createReadStream);

    if (buffer === 'could not read file') {
        return { error: {
                field: 'post',
                message: buffer
            }
        }
    }
    console.log(buffer);
    // const key = 'posts/' + uuidv4() + '.jpg';

    const s3Result = await uploadImageToS3(key, (buffer as any), contentType);

    if (s3Result === false) {
        return { error: 
            {
                field: 'post',
                message: 'could not upload post'
            }
        };
    }

    return ;
}