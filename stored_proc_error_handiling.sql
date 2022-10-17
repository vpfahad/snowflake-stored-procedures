CREATE OR REPLACE procedure MY_PROC(PARAM float)
  RETURNS VARIANT NOT NULL
  LANGUAGE JAVASCRIPT 
AS
$$
    try {
      var msg = [];
      msg.push({prc:'MY_PROC checkpoint 1:'+ new Date().toISOString(),txt:'test'});
      A= snowflake.execute({ sqlText:`select 1/`+ PARAM});
      A.next();    
      return_val = A.getColumnValue(1);
msg.push({prc:'MY_PROC checkpoint 2:'+ new Date().toISOString(),txt:'test finished.'});
      return {status:1, ret:return_val, msg:msg};
    }
    catch(err) {
        msg.push({prc:'MY_PROC checkpoint 3:'+ new Date().toISOString(),txt:'FAILED:' + err});
        return {status:0, ret:null, msg: msg};
    }
$$;