package com.bitware.utils;

import com.alibaba.fastjson.JSONObject;
import com.bitware.bean.BitResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.UUID;

@Controller
@RequestMapping("/fileUpload")
public class FileUploadUtil {

    public static final int THUMBNAIL_IMAGE_WIDTH = 700;//图片缩略图处理
    public static final int THUMBNAIL_IMAGE_HEIGHT = 700;//图片缩略图处理
    public static final String ALLOWED_UPLOAD_IMAGE = "jpg,jpeg,bmp,gif,png";//允许上传的图片类型
    public static final long EXTENSION_LENGTH = 5485000;//下划线

    @RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
    @ResponseBody
    public BitResult uploadImg(HttpServletRequest request, HttpServletResponse response) {


        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Iterator<String> a = multipartRequest.getFileNames();

        //返回值
        JSONObject jsonObject = new JSONObject();

        //获取路径
        String path = System.getProperty("java.class.path");
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyyMMdd");
        try {
            //获取当前时间
            String date = bartDateFormat.format(new Date());

            //获取存放路径
            path = path.substring(0, path.lastIndexOf("jboss-modules.jar")) + "upload/" + date;
            /**
             * 可能会出现重复文件，所以我们要对文件进行一个重命名的操作
             * 截取文件的原始名称，然后将扩展名和文件名分开，使用：时间戳-文件名.扩展名的格式保存
             */
            if (a.hasNext()) {
                //获取上传文件
                MultipartFile file = multipartRequest.getFile(a.next());

                // 获取文件名称
                String fileName = new String(file.getOriginalFilename().getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8).replace(" ","");
                // 获取扩展名
                String fileExtensionName = fileName.substring(fileName.lastIndexOf(".") + 1);

                String[] imageExtensionArray = ALLOWED_UPLOAD_IMAGE.split(",");

/*                if (!ArrayUtils.contains(imageExtensionArray,fileExtensionName)) {
                    String message = "只允许上传图片文件类型: "+ ALLOWED_UPLOAD_IMAGE + "!";
                    return ResultGenerator.genFailResult(message);
                }else if (file.getSize() > EXTENSION_LENGTH){
                    String message = "此上传文件大小超出限制!";
                    return ResultGenerator.genFailResult(message);
                }*/
                // 获取文件名
                String name = fileName.substring(0, fileName.lastIndexOf("."));
                String id = UUID.randomUUID().toString();
                //原图
                String sourceFileName = id + "-" + name + "." + fileExtensionName;
                //缩略图名称
                String thumbnailsFileName = id + "-" + name + "_thumbnails" + "." + fileExtensionName;
                /**
                 * 上传操作：可能目录不存在，所以先判断一下如果不存在，那么新建这个目录
                 */
                File fileDir = new File(path);
                if (!fileDir.exists()) {
                    fileDir.setWritable(true);
                    fileDir.mkdirs();
                }
                /**
                 * 上传
                 */
                File sourceFile = new File(path, sourceFileName);
                try {
                    file.transferTo(sourceFile);
                } catch (IOException e) {
                    e.printStackTrace();
                }

                //缩略图
                File thumbnailFile = new File(path, thumbnailsFileName);

                BufferedImage srcBufferedImage = ImageIO.read(sourceFile);

                //处理缩略图
                ImageUtil.zoom(srcBufferedImage, thumbnailFile, THUMBNAIL_IMAGE_HEIGHT, THUMBNAIL_IMAGE_WIDTH);

                //返回值
                jsonObject.put("sourceFileUrl", String.format("/" + date + "/%s", sourceFileName));
                jsonObject.put("thumbnailFile", String.format("/" + date + "/%s", thumbnailsFileName));

            }
            return  BitResult.success(jsonObject);
        } catch (Exception e) {
            return  BitResult.failure("上传图片失败，请稍后重试！");
        }

    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public BitResult upload(HttpServletRequest request, HttpServletResponse response) {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Iterator<String> a = multipartRequest.getFileNames();

        //返回值
        JSONObject jsonObject = new JSONObject();

        //获取路径
        String path = System.getProperty("java.class.path");
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyyMMdd");
        try {
            //获取当前时间
            String date = bartDateFormat.format(new Date());

            //获取存放路径
            path = path.substring(0, path.lastIndexOf("jboss-modules.jar")) + "upload/" + date;
            /**
             * 可能会出现重复文件，所以我们要对文件进行一个重命名的操作
             * 截取文件的原始名称，然后将扩展名和文件名分开，使用：时间戳-文件名.扩展名的格式保存
             */
            if (a.hasNext()) {
                //获取上传文件
                MultipartFile file = multipartRequest.getFile(a.next());

                // 获取文件名称
                String fileName = new String(file.getOriginalFilename().getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8).replace(" ","");
                // 获取扩展名
                String fileExtensionName = fileName.substring(fileName.lastIndexOf(".") + 1);

                // 获取文件名
                String name = fileName.substring(0, fileName.lastIndexOf("."));
                // 生成最终保存的文件名,格式为: UUID-文件名.扩展名
                String id = UUID.randomUUID().toString();
                //文件名
                String saveFileName = id + "-" + name + "." + fileExtensionName;
                /**
                 * 上传操作：可能目录不存在，所以先判断一下如果不存在，那么新建这个目录
                 */
                File fileDir = new File(path);
                if (!fileDir.exists()) {
                    fileDir.setWritable(true);
                    fileDir.mkdirs();
                }
                /**
                 * 上传
                 */
                File sourceFile = new File(path, saveFileName);
                try {
                    file.transferTo(sourceFile);
                } catch (IOException e) {
                    e.printStackTrace();
                }

                //返回值
                jsonObject.put("fileUrl", String.format("/" + date + "/%s", saveFileName));
            }
            return  BitResult.success(jsonObject);
        } catch (Exception e) {
            return  BitResult.failure("上传失败，请稍后重试！");
        }

    }
}
