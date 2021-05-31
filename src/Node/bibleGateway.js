
const axios = require('axios');
const cheerio = require('cheerio');

class bibleGateWay{

    constructor(request){
        this.request = request;
    }
    
    get(){
        let url = this.request.url;

        return axios.get(url, {
            params: {
            search: this.request.passage,
            version: this.request.version
            }
        });
    }

    process(result){     
        const $ = cheerio.load(result.data);
        const heading = $('meta[name="twitter:title"]').attr("content");
        const passage = $('meta[property="og:description"]').attr("content");

        return{
            heading: heading,
            passage: passage
        };   
    }
}

module.exports = bibleGateWay;