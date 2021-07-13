package main

import (
   "github.com/gin-gonic/gin"
   "net/http"
)

func main() {
   r := gin.Default()
   v1 := r.Group("/v1")
   {
     v1.POST("/post", func(c *gin.Context) {
       c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
       message := c.PostForm("message")
       c.JSON(200, gin.H{"status": message })
     })

     v1.GET("/get", func(c *gin.Context) {
       c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
       c.JSON(http.StatusOK, gin.H{"message": "Welcome Test Go Gin Get API!"})
     })
   }
   //定义默认路由
   r.NoRoute(func(c *gin.Context) {
      c.JSON(http.StatusNotFound, gin.H{
         "status": 404,
         "error":  "404, page not exists!",
      })
   })
   r.Run(":8000")
}
