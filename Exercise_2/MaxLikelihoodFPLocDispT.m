function [mu,sig2] = MaxLikelihoodFPLocDispT(et_array,v,threshold)

%et_array should be {vec(e),p} for each t where size(e) = i from 1 to
%\bar{t}. To get \bar{t} from this, we can just measure size of p array
et_dim = size(et_array{:,1});
t_bar = et_dim(1); %sample_size
i_bar = et_dim(2); %dimension 

%initialize mu_hfp
mu =0;
e = @(t) (et_array{1}(t,:)).';% individual sample vector
p = @(t) et_array{2}(t); %vector of probabilties

for t = 1:t_bar
    mu = mu +p(t)*e(t); 
end

%initialize sig2_hfp
sig2 =0;
for t = 1:t_bar
    sig2=sig2+p(t)*(e(t)-mu)*(e(t)-mu).';
end

%define weights
w =[];
for t = 1:t_bar
    w=[w,((v+i_bar)/(v+(e(t)-mu).'*sig2^(-2)*(e(t)-mu)))];
end

%define norms
mu_n = @(a,b)norm(a-b)/norm(b);
sig_f = @(a,b)norm(a-b,'fro')/norm(b,'fro');

%Perform loops and check threshold
flag = true;
mu_previous_step=0;
sig2_previous_step=0;
mu_t=mu;
sig2_t=sig2;
no_of_loops=0;

while flag
    no_of_loops=no_of_loops+1;
    w =[];
    for t = 1:t_bar        
        w=[w,((v+i_bar)/(v+(e(t)-mu_t).'*sig2_t^(-2)*(e(t)-mu_t)))];
    end
    %mu_t = symsum(p(t)*w(t)*e(t),t,1,t_bar)/symsum(p(s)*w(s),s,1,t_bar);
    %sig2_t =symsum(p(t)*w(t)*(e(t)-mu_t)*(e(t)-mu_t).',t,1,t_bar);
    %symsum is not native to computer hardware, thus is very slow use for
    %loops instead
    
    %Mean
    mu_top =0;
    mu_bot =0;
    for t = 1:t_bar
        mu_top=mu_top+p(t)*w(t)*e(t);
        mu_bot=mu_bot+p(t)*w(t);
    end
    mu_t = mu_top/mu_bot;
    
    %Covariance
    sig2_t=0;
    for t=1:t_bar
        sig2_t=sig2_t +p(t)*w(t)*(e(t)-mu_t)*(e(t)-mu_t).';
    end
    if mu_n(mu_previous_step,mu_t) && sig_f(sig2_previous_step,sig2_t)<threshold
        mu=mu_t;
        sig2=sig2_t;
        flag=false;
    else
        mu=mu_t;
        sig2=sig2_t;
        mu_previous_step = mu_t;
        sig2_previous_step=sig2_t;
    end
    
    
end
    no_of_loops

end
    



