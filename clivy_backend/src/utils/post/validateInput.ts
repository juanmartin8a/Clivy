import { FileUpload } from "graphql-upload";
//import { CreatePostInput } from "./postInput";


export const validatePost = async (caption: string, file: FileUpload) => {
	if (!file) {
		console.log('saposalsa');
		return {
			field: 'file',
			message: 'no file selected'
		}
	}

  if (caption.length > 160) {
		return {
			field: 'caption',
			message: 'caption length must not exceed 160 characters'
		}
	}
	return null;
}