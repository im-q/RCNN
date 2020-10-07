# [RCNN](https://github.com/tfzoo/RCNN)

[![sites](http://182.61.61.133/link/resources/qitas.png)](http://www.tfzoo.com)

object detection就是在给定的图片中精确找到物体所在位置，并标注出物体的类别。所以，object detection要解决的问题就是物体在哪里以及是什么的整个流程问题。然而，这个问题可不是那么容易解决的，物体的尺寸变化范围很大，摆放物体的角度，姿态不定，而且可以出现在图片的任何地方，更何况物体还可以是多个类别。

目前学术和工业界出现的目标检测算法分成3类：

1. 传统的目标检测算法：Cascade + HOG/DPM + Haar/SVM以及上述方法的诸多改进、优化；
2. 候选区域/框 + 深度学习分类：通过提取候选区域，并对相应区域进行以深度学习方法为主的分类的方案，如：

* R-CNN（Selective Search + CNN + SVM）
* SPP-net（ROI Pooling）
* Fast R-CNN（Selective Search + CNN + ROI）
* Faster R-CNN（RPN + CNN + ROI）
* R-FCN

3. 基于深度学习的回归方法：YOLO/SSD/DenseBox 等方法；以及最近出现的结合RNN算法的RRC detection；结合DPM的Deformable CNN等

---

R-CNN（Region CNN，区域卷积神经网络）可以说是利用深度学习进行目标检测的开山之作，作者Ross Girshick多次在PASCAL VOC的目标检测竞赛中折桂，2010年更是带领团队获得了终身成就奖，如今就职于Facebook的人工智能实验室（FAIR）。

RCNN -> SPPNET -> Fast-RCNN -> Faster-RCNN

R-CNN 系统分为 3 个阶段，反应到架构上由 3 个模块完成。

* 生产类别独立的候选区域，这些候选区域其中包含了 R-CNN 最终定位的结果。
* 神经网络去针对每个候选区域提取固定长度的特征向量。
* 一系列的 SVM 分类器。
