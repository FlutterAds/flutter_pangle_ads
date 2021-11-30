package com.zero.flutter_pangle_ads.utils;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * 数据工具类
 */
public class DataUtils {
    /**
     * 转换为 int []
     *
     * @param integers List<Integer>
     * @return int []
     */
    public static int[] convertIntegers(ArrayList integers) {
        if (integers == null) {
            return new int[]{};
        }
        int[] ret = new int[integers.size()];
        Iterator<Integer> iterator = integers.iterator();
        for (int i = 0; i < ret.length; i++) {
            ret[i] = iterator.next().intValue();
        }
        return ret;
    }
}
