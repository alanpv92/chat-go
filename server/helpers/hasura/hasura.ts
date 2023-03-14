import axios from "axios";
import ConstantHelper from "../constants/constants";

class HasuraHelper {
  private static instance: HasuraHelper;
  private constructor() {}
  public static getInstance(): HasuraHelper {
    if (!HasuraHelper.instance) {
      this.instance = new HasuraHelper();
    }
    return this.instance;
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
      return response.data['data'];
    } catch (e: any) {
      const errorText = e.message || "something went wrong";
      
      throw new Error(errorText);
    }
  }
}

export default HasuraHelper;