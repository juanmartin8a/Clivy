import { UserUpdateInput } from "./userInput";

export const generateUpdateUserSQL = async (
    input: UserUpdateInput, 
    username: string,
    name: string,
    bio: string
) => {

  let updateValues: string = "";
  
  Object.entries(input).map(([key, value]) => {
    if (value !== undefined && value !== null) {
      if (
        (value !== username && key === "username") ||
        (value !== name && key === "name") ||
        (value !== bio && key === "bio")
      ) {
        if (updateValues === "") {
          updateValues = updateValues + `"${key}": "${value}"`;
        } else {
          updateValues = updateValues + ", " + `"${key}": "${value}"`;
        }
      }
    }
  });

  if (updateValues === "") {
    return {};
  }

  const updatedInput = "{" + updateValues + "}";

  const parsedUpdatedInput = await JSON.parse(updatedInput)

  return parsedUpdatedInput;
}