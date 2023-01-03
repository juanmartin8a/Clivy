import { ReadStream } from "typeorm/platform/PlatformTools";


export const getFileBuffer = async (createReadStream: () => ReadStream) => {
    console.log('readStream: ' + createReadStream);

    const buffers: Buffer[] = [];

    const buffer = await new Promise(async (resolve) => {
        createReadStream()
        .on("data", chunk => {
            buffers.push(Buffer.from(chunk));
        })
        .on("end", () => {
            resolve(Buffer.concat(buffers));
        })
        .on("error", (err) => {
            console.log("the error is: " + err)
            resolve('could not read file');
        });
    });

    return buffer;
}