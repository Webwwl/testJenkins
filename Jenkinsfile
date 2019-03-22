// jenkins 脚本文件

node {
	try{
		stage('检出代码'){//从git仓库中检出代码
            echo '开始clone代码'
	    	git branch: "${params.BRANCH}",credentialsId: 'wwl', url: "${params.REPO_URL}"
            echo 'clone代码成功' 
	       	loadProjectConfig();
	  	}
	   	stage('项目信息'){
	   		//这里是构建，你可以调用job入参或者项目配置的参数，比如：
	   		echo "项目名字 ${PROJECT_CHINESE_NAME}"
			echo '文件信息'
			sh 'ls -R config'
	   		//可以判断
	   		if (Boolean.valueOf("${IS_USE_CODE_CHECK}")) {
	   			echo "需要静态代码检查"
	   		} else {
	   			echo "不需要静态代码检查"
	   		}
			if ("${params.COMMIID}" != "") {
				sh "git checkout ${params.COMMITID}"
				echo "checkout to ${params.COMMITID}"
			}
	   	}
	   	stage("打包"){//这个演示的Android的项目，实际使用中，请根据自己的产物确定
	       	// sh "cnpm install"
            // sh "cnpm run build"
			sh "config/deploy/test.sh"
	   	}
        stage("发布") {
            sh "cp -r ./dist/* ${params.TARGETDIR}"
        }
	   	stage("通知负责人"){
	   		emailext body: "构建项目:${PROJECT_CHINESE_NAME}\r\n构建完成\r\n 线上地址：https://www.wuwenliang.xyz/source/project/test-jenkins/index.html", subject: '构建结果通知【成功】', to: "${EMAIL}"
	   	}
	} catch (e) {
		emailext body: "构建项目:${PROJECT_CHINESE_NAME}\r\n构建失败，\r\n错误消息：${e.toString()}", subject: '构建结果通知【失败】', to: "${EMAIL}"
	} finally{
		// 清空工作空间
        // cleanWs notFailBuild: true
	}
   	
   
}

//加载项目里面的配置文件
def loadProjectConfig(){
    def jenkinsConfigFile="./jenkins.groovy"
    if (fileExists("${jenkinsConfigFile}")) {
        load "${jenkinsConfigFile}"
        echo "找到打包参数文件${jenkinsConfigFile}，加载成功"
    } else {
        echo "${jenkinsConfigFile}不存在,请在项目${jenkinsConfigFile}里面配置打包参数"
        sh "exit 1"
    }
}
