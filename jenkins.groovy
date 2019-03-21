// 项目jenkins配置文件

// 项目名称
env.PROJECT_ENGLISH_NAME = 'test-jenkins'
env.PROJECT_CHINESE_NAME = 'jenkins尝鲜'
env.IS_USE_CODE_CHECK = isPro()
// 是否是生产
def isPro() {
    if("${params.BRANCH}" == 'master') {
        return true
    } else {
        return false
    }
}