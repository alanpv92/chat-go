import axios from "axios";
import ConstantHelper from "../constants/constants";

class HasuraHelper {
  private static intance: HasuraHelper;
  private constructor() {}
  public static getInstance(): HasuraHelper {
    if (!HasuraHelper.getInstance) {
      this.intance = new HasuraHelper();
    }
    return this.intance;
  }

  async query(queryString: String) {
    try {
      let response = await axios.post(ConstantHelper.hasuraBaseUrl, {
        query: queryString,
      });
      if (response.data["errors"]) {
        throw new Error(
          response.data["errors"][0]["message"] || "something went wrong"
        );
      }
    } catch (e: any) {
      const errorText = e.message || "something went wrong";
      throw new Error(errorText);
    }
  }
}

export default HasuraHelper;