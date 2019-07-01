//
//  ImageLineChartRenderer.swift
//  StatsPlayground
//
//  Created by Anil Kumar on 07/03/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import Foundation

class ImageLineChartRenderer: LineChartRenderer {
    private final LineChart lineChart;
    private final Bitmap image;
    
    
    ImageLineChartRenderer(LineChart chart, ChartAnimator animator, ViewPortHandler viewPortHandler, Bitmap image) {
    super(chart, animator, viewPortHandler);
    this.lineChart = chart;
    this.image = image;
    }
    
    private float[] mCirclesBuffer = new float[2];
    
    @Override
    protected void drawCircles(Canvas c) {
    mRenderPaint.setStyle(Paint.Style.FILL);
    float phaseY = mAnimator.getPhaseY();
    mCirclesBuffer[0] = 0;
    mCirclesBuffer[1] = 0;
    List<ILineDataSet> dataSets = mChart.getLineData().getDataSets();
    
    //Draw bitmap image for every data set with size as radius * 10, and store it in scaled bitmaps array
    Bitmap[] scaledBitmaps = new Bitmap[dataSets.size()];
    float[] scaledBitmapOffsets = new float[dataSets.size()];
    for (int i = 0; i < dataSets.size(); i++) {
    float imageSize = dataSets.get(i).getCircleRadius() * 10;
    scaledBitmapOffsets[i] = imageSize / 2f;
    scaledBitmaps[i] = scaleImage((int) imageSize);
    }
    
    for (int i = 0; i < dataSets.size(); i++) {
    ILineDataSet dataSet = dataSets.get(i);
    
    if (!dataSet.isVisible() || !dataSet.isDrawCirclesEnabled() || dataSet.getEntryCount() == 0)
    continue;
    
    mCirclePaintInner.setColor(dataSet.getCircleHoleColor());
    Transformer trans = mChart.getTransformer(dataSet.getAxisDependency());
    mXBounds.set(mChart, dataSet);
    
    
    int boundsRangeCount = mXBounds.range + mXBounds.min;
    for (int j = mXBounds.min; j <= boundsRangeCount; j++) {
    Entry e = dataSet.getEntryForIndex(j);
    if (e == null) break;
    mCirclesBuffer[0] = e.getX();
    mCirclesBuffer[1] = e.getY() * phaseY;
    trans.pointValuesToPixel(mCirclesBuffer);
    if (!mViewPortHandler.isInBoundsRight(mCirclesBuffer[0]))
    break;
    if (!mViewPortHandler.isInBoundsLeft(mCirclesBuffer[0]) || !mViewPortHandler.isInBoundsY(mCirclesBuffer[1]))
    continue;
    
    if (scaledBitmaps[i] != null) {
    c.drawBitmap(scaledBitmaps[i],
    mCirclesBuffer[0] - scaledBitmapOffsets[i],
    mCirclesBuffer[1] - scaledBitmapOffsets[i],
    mRenderPaint);
    }
    }
    }
    
    }
    
    
    private Bitmap scaleImage(int radius) {
    return Bitmap.createScaledBitmap(image, radius, radius, false);
    }
}
