def barplot(data1,measure,palette):
    plt.figure(figsize=(20, 10))
    sns.set_style("whitegrid")
    x_order=list(describe(data1)[measure].sort_values("std").index)
    ax=sns.boxplot(data=data2,y=measure,x="type",order=x_order)
    ax.set_title('normalized power')
    pos=range(len(x_order))
    for tick,label in zip(pos,ax.get_xticklabels()):
        ax.text(pos[tick],describe(data1)[measure].loc[x_order[tick]]["max"]+0.03, x_order[tick],horizontalalignment='center', weight='semibold')

# sns.plt.show()



docker run --rm -it --net aloha powerapi mongobase  27017  variation  'raplNpbDahu3-5modes'  \
                      mongobase  27017  variation 'powersNpbDahu3x5modes' \
                      SOCKET


data["type"]=data.apply(lambda row :row["machineName"]+"_"+re.sub(r'new(.*)Test([^\d]*)\d+',r'\1\2',row["target"]),axis=1)